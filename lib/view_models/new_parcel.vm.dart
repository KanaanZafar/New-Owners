import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/coupon.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/order_stop.dart';
import 'package:fuodz/models/package_checkout.dart';
import 'package:fuodz/models/package_type.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/cart.request.dart';
import 'package:fuodz/requests/checkout.request.dart';
import 'package:fuodz/requests/package.request.dart';
import 'package:fuodz/requests/payment_method.request.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:jiffy/jiffy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';

class NewParcelViewModel extends PaymentViewModel {
  //
  PackageRequest packageRequest = PackageRequest();
  CartRequest cartRequest = CartRequest();
  VendorRequest vendorRequest = VendorRequest();
  PaymentMethodRequest paymentOptionRequest = PaymentMethodRequest();
  CheckoutRequest checkoutRequest = CheckoutRequest();
  Function onFinish;
  VendorType vendorType;

  //Step 1
  List<PackageType> packageTypes = [];
  PackageType selectedPackgeType;

  //Step 2
  List<Vendor> vendors = [];
  Vendor selectedVendor;
  bool requireParcelInfo = true;

  //Step 3
  DeliveryAddress pickupLocation;
  DeliveryAddress dropoffLocation;
  DateTime selectedPickupDate;
  String pickupDate;
  TimeOfDay selectedPickupTime;
  String pickupTime;

  final deliveryInfoFormKey = GlobalKey<FormState>();
  TextEditingController fromTEC = TextEditingController();
  TextEditingController toTEC = TextEditingController();
  List<TextEditingController> toTECs = [];
  TextEditingController dateTEC = TextEditingController();
  TextEditingController timeTEC = TextEditingController();
  bool isScheduled = false;
  List<String> availableTimeSlots = [];

  //step 4
  //receipents
  int openedRecipientFormIndex = 0;
  final recipientInfoFormKey = GlobalKey<FormState>();
  List<TextEditingController> recipientNamesTEC = [TextEditingController()];
  List<TextEditingController> recipientPhonesTEC = [TextEditingController()];
  List<TextEditingController> recipientNotesTEC = [TextEditingController()];

  //step 5
  final packageInfoFormKey = GlobalKey<FormState>();
  TextEditingController packageWeightTEC = TextEditingController();
  TextEditingController packageHeightTEC = TextEditingController();
  TextEditingController packageWidthTEC = TextEditingController();
  TextEditingController packageLengthTEC = TextEditingController();
  TextEditingController noteTEC = TextEditingController();

  //packageCheckout
  PackageCheckout packageCheckout = PackageCheckout();
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod selectedPaymentMethod;
  //
  bool canApplyCoupon = false;
  Coupon coupon;
  TextEditingController couponTEC = TextEditingController();

  //
  int activeStep = 0;
  PageController pageController = PageController();
  StreamSubscription currentLocationChangeStream;

  //
  NewParcelViewModel(BuildContext context, this.onFinish, this.vendorType) {
    this.viewContext = context;
  }

  void initialise() async {
    //
    //listen to user location change
    currentLocationChangeStream =
        LocationService.currenctAddressSubject.stream.listen(
      (location) async {
        //

        deliveryaddress.address = location.addressLine;
        deliveryaddress.latitude = location.coordinates.latitude;
        deliveryaddress.longitude = location.coordinates.longitude;
        //get city, state & country
        deliveryaddress = await getLocationCityName(deliveryaddress);
        notifyListeners();
      },
    );
    //
    if (AppStrings.enableParcelMultipleStops) {
      packageCheckout.stopsLocation = [];
      addNewStop();
    }
    await fetchParcelTypes();
    await fetchPaymentOptions();
  }

  //
  dispose() {
    super.dispose();
    currentLocationChangeStream.cancel();
  }

  //
  fetchParcelTypes() async {
    //
    setBusyForObject(packageTypes, true);
    try {
      packageTypes = await packageRequest.fetchPackageTypes();
      clearErrors();
    } catch (error) {
      setErrorForObject(packageTypes, error);
    }
    setBusyForObject(packageTypes, false);
  }

  fetchParcelVendors() async {
    //
    vendors = [];
    setBusyForObject(vendors, true);
    try {
      vendors = await vendorRequest.fetchParcelVendors(
        vendorTypeId: vendorType.id,
        packageTypeId: selectedPackgeType.id,
        deliveryAddress: deliveryaddress,
      );

      //
      if (AppStrings.enableSingleVendor) {
        changeSelectedVendor(vendors.first);
      }
      clearErrors();
    } catch (error) {
      setErrorForObject(vendors, error);
    }
    setBusyForObject(vendors, false);
  }

  //
  fetchPaymentOptions() async {
    setBusyForObject(paymentMethods, true);
    try {
      paymentMethods = await paymentOptionRequest.getPaymentOptions();
      clearErrors();
    } catch (error) {
      print("Error getting payment methods ==> $error");
    }
    setBusyForObject(paymentMethods, false);
  }

  ///FORM MANIPULATION
  nextForm(int index) {
    activeStep = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  //
  void changeSelectedPackageType(PackageType packgeType) async {
    selectedPackgeType = packgeType;
    packageCheckout.packageType = selectedPackgeType;
    notifyListeners();
    await fetchParcelVendors();
  }

  changeSelectedVendor(Vendor vendor) {
    selectedVendor = vendor;
    packageCheckout.vendor = selectedVendor;
    final vendorPackagePricing = selectedVendor.packageTypesPricing.firstWhere(
      (e) => e.packageTypeId == selectedPackgeType.id,
      orElse: () => null,
    );

    if (vendorPackagePricing != null) {
      requireParcelInfo = vendorPackagePricing.fieldRequired ?? true;
    }
    notifyListeners();
  }

  //
  changePickupAddress() async {
    //check that user is logged in to countinue else go to login page
    if (!AuthServices.authenticated()) {
      final result =
          await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
      paymentOptionRequest = PaymentMethodRequest();
      if (result == null || !result) {
        return;
      }
    }

    final result = await showDeliveryAddressPicker();
    if (result != null) {
      pickupLocation = result;
      fromTEC.text = pickupLocation.address;
      //
      packageCheckout.pickupLocation = pickupLocation;
      notifyListeners();
    }
  }

  //
  changeDropOffAddress() async {
    //check that user is logged in to countinue else go to login page
    if (!AuthServices.authenticated()) {
      final result =
          await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
      paymentOptionRequest = PaymentMethodRequest();
      if (result == null || !result) {
        return;
      }
    }

    final result = await showDeliveryAddressPicker();
    if (result != null) {
      dropoffLocation = result;
      toTEC.text = dropoffLocation.address;
      //
      packageCheckout.dropoffLocation = dropoffLocation;
      notifyListeners();
    }
  }

  //
  changeStopDeliveryAddress(int index) async {
    //check that user is logged in to countinue else go to login page
    if (!AuthServices.authenticated()) {
      final result =
          await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
      paymentOptionRequest = PaymentMethodRequest();
      if (result == null || !result) {
        return;
      }
    }

    final result = await showDeliveryAddressPicker();
    if (result != null) {
      dropoffLocation = result;
      toTECs[index].text = dropoffLocation.address;
      //
      packageCheckout.stopsLocation[index] = new OrderStop();
      packageCheckout.stopsLocation[index].deliveryAddress = dropoffLocation;
      notifyListeners();
    }
  }

  //

  //
  toggleScheduledOrder(bool value) {
    isScheduled = value;
    packageCheckout.isScheduled = isScheduled;
    //remove delivery address if pickup
    if (isScheduled) {
      packageCheckout.date = null;
      packageCheckout.time = null;
    } else {
      packageCheckout.date = null;
      packageCheckout.time = null;
    }

    notifyListeners();
  }

  //start of schedule related
  changeSelectedDeliveryDate(String string, int index) {
    packageCheckout.deliverySlotDate = string;
    packageCheckout.date = string;
    pickupDate = string;
    availableTimeSlots = selectedVendor.deliverySlots[index].times;
    notifyListeners();
  }

  changeSelectedDeliveryTime(String time) {
    packageCheckout.deliverySlotTime = time;
    packageCheckout.time = time;
    pickupTime = time;
    notifyListeners();
  }

  //
  changeDropOffDate() async {
    final result = await showDatePicker(
      context: viewContext,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: selectedVendor.packageTypesPricing.first.maxBookingDays ?? 7,
        ),
      ),
      initialDate: selectedPickupDate ?? DateTime.now(),
    );

    //
    if (result != null) {
      selectedPickupDate = result;
      pickupDate =
          Jiffy.unixFromMillisecondsSinceEpoch(result.millisecondsSinceEpoch).format("yyyy-MM-dd");
      dateTEC.text = Jiffy.unixFromMillisecondsSinceEpoch(result.millisecondsSinceEpoch).yMMMMd;
      packageCheckout.date = pickupDate;
      notifyListeners();
    }
  }

  changeDropOffTime() async {
    final result = await showTimePicker(
      context: viewContext,
      initialTime: selectedPickupTime ?? TimeOfDay.now(),
    );

    //
    if (result != null) {
      selectedPickupTime = result;
      pickupTime = result.format(viewContext);
      timeTEC.text = pickupTime;

      try {
        packageCheckout.time = "${result.hour}:${result.minute}";
      } catch (error) {
        packageCheckout.time = "$pickupTime";
      }
      notifyListeners();
    }
  }

  changeSelectedPaymentMethod(PaymentMethod paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    packageCheckout.paymentMethod = paymentMethod;
    notifyListeners();
  }

  //Form validationns
  validateDeliveryInfo() {
    if (deliveryInfoFormKey.currentState.validate()) {
      nextForm(3);
    }
  }

  // Recipient
  validateRecipientInfo() {
    //
    recipientInfoFormKey.currentState.validate();
    bool dataRequired = false;
    //loop throug the recipents
    recipientNamesTEC.forEachIndexed((index, element) {
      if (element.text.isEmpty) {
        dataRequired = true;
        return;
      }
    });

    recipientPhonesTEC.forEachIndexed((index, element) {
      if (element.text.isEmpty ||
          FormValidator.validatePhone(element.text) != null) {
        dataRequired = true;
        return;
      }
    });

    if (dataRequired) {
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.warning,
        title: "Fill Contact Info".i18n,
        text:
            "Please ensure you fill in contact info for all added stops. Thank you"
                .i18n,
        onConfirmBtnTap: () {
          //hide keyboard
          FocusScope.of(viewContext).requestFocus(FocusNode());
          viewContext.pop();
        },
      );

      return;
    }

    //
    if (recipientInfoFormKey.currentState.validate()) {
      //loop through recipients
      // recipientNamesTEC

      // packageCheckout.recipientName = recipientNameTEC.text;
      // packageCheckout.recipientPhone = recipientPhoneTEC.text;
      nextForm(4);
    }
  }

  validateDeliveryParcelInfo() {
    if (packageInfoFormKey.currentState.validate()) {
      //
      packageCheckout.weight = packageWeightTEC.text;
      packageCheckout.width = packageWidthTEC.text;
      packageCheckout.length = packageLengthTEC.text;
      packageCheckout.height = packageHeightTEC.text;
      //hide keyboard
      FocusScope.of(viewContext).unfocus();
      nextForm(5);
    }
  }

  //Submit form
  prepareOrderSummary() async {
    //
    nextForm(6);
    setBusyForObject(packageCheckout, true);
    try {
      List<OrderStop> allStops = [];
      if (packageCheckout.pickupLocation != null) {
        allStops
            .add(OrderStop(deliveryAddress: packageCheckout.pickupLocation));
      }

      if (packageCheckout.stopsLocation != null &&
          packageCheckout.stopsLocation.isNotEmpty) {
        allStops.addAll(packageCheckout.stopsLocation);
      }
      if (packageCheckout.dropoffLocation != null) {
        allStops
            .add(OrderStop(deliveryAddress: packageCheckout.dropoffLocation));
      }

      //

      //
      recipientNamesTEC.forEachIndexed((index, element) {
        allStops[index].stopId = allStops[index].deliveryAddress.id;
        allStops[index].name = element.text;
        allStops[index].phone = recipientPhonesTEC[index].text;
        allStops[index].note = recipientNotesTEC[index].text;
      });

      //
      packageCheckout.allStops = allStops;

      //
      final mPackageCheckout = await packageRequest.parcelSummary(
        vendorId: selectedVendor.id,
        packageTypeId: selectedPackgeType.id,
        stops: allStops,
        packageWeight: packageWeightTEC.text,
      );

      //
      packageCheckout.copyWith(packageCheckout: mPackageCheckout);

      clearErrors();
    } catch (error) {
      print("Package error ==> $error");
      setErrorForObject(packageCheckout, error);
    }
    setBusyForObject(packageCheckout, false);
  }

  couponCodeChange(String code) {
    canApplyCoupon = code.isNotBlank;
    notifyListeners();
  }

  //
  applyCoupon() async {
    //
    setBusyForObject(coupon, true);
    try {
      coupon = await cartRequest.fetchCoupon(couponTEC.text);
      //
      if (coupon.useLeft <= 0) {
        throw "Coupon use limit exceeded".i18n;
      } else if (coupon.expired) {
        throw "Coupon has expired".i18n;
      }
      clearErrors();
      //re-calculate the cart price with coupon
      //
      if (coupon.percentage == 1) {
        packageCheckout.discount = (coupon.discount / 100) * packageCheckout.subTotal;
      } else {
        packageCheckout.discount = coupon.discount;
      }
    } catch (error) {
      print("error ==> $error");
      setErrorForObject(coupon, error);
    }
    setBusyForObject(coupon, false);
  }

  //Submit form
  initiateOrderPayment() async {
    //show loading dialog
    CoolAlert.show(
      context: viewContext,
      type: CoolAlertType.loading,
      barrierDismissible: false,
      title: "Checkout".i18n,
      text: "Processing order. Please wait...".i18n,
    );

    try {
      //
      final apiResponse = await checkoutRequest.newPackageOrder(
        packageCheckout,
        note: noteTEC.text,
      );

      //close loading dialog
      viewContext.pop();

      //not error
      if (apiResponse.allGood) {
        //cash payment

        final paymentLink = apiResponse.body["link"].toString();
        if (!paymentLink.isEmpty) {
          showOrdersTab();
          openWebpageLink(paymentLink);
        }
        //cash payment
        else {
          CoolAlert.show(
              context: viewContext,
              type: CoolAlertType.success,
              title: "Checkout".i18n,
              text: apiResponse.message,
              barrierDismissible: false,
              onConfirmBtnTap: () {
                viewContext.pop();
                showOrdersTab();
              });
        }
      } else {
        CoolAlert.show(
          context: viewContext,
          type: CoolAlertType.error,
          title: "Checkout".i18n,
          text: apiResponse.message,
        );
      }
    } catch (error) {
      print("Error ==> $error");
    }
  }

  //
  showOrdersTab() {
    //
    viewContext.pop();
    //switch tab to orders
    AppService().changeHomePageIndex(index: 1);
  }

  addNewStop() {
    if (AppStrings.maxParcelStops > (toTECs.length - 1)) {
      final toTEC = TextEditingController();
      toTECs.add(toTEC);
      //
      recipientNamesTEC.add(TextEditingController());
      recipientPhonesTEC.add(TextEditingController());
      recipientNotesTEC.add(TextEditingController());
      //
      packageCheckout.stopsLocation.add(null);
      notifyListeners();
    }
  }

  removeStop(int index) {
    toTECs.removeAt(index);
    recipientNamesTEC.removeAt(index);
    recipientPhonesTEC.removeAt(index);
    recipientNotesTEC.removeAt(index);
    packageCheckout.stopsLocation.removeAt(index);
    notifyListeners();
  }
}
