import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/requests/checkout.request.dart';
import 'package:fuodz/requests/delivery_address.request.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/requests/payment_method.request.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/view_models/payment.view_model.dart';
import 'package:fuodz/widgets/bottomsheets/delivery_address_picker.bottomsheet.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:jiffy/jiffy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';
import 'package:supercharged/supercharged.dart';

class CheckoutBaseViewModel extends PaymentViewModel {
  //
  CheckoutRequest checkoutRequest = CheckoutRequest();
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  PaymentMethodRequest paymentOptionRequest = PaymentMethodRequest();

  VendorRequest vendorRequest = VendorRequest();
  TextEditingController driverTipTEC = TextEditingController();
  TextEditingController noteTEC = TextEditingController();
  DeliveryAddress deliveryAddress;
  bool isPickup = false;
  bool isScheduled = false;
  List<String> availableTimeSlots = [];
  bool delievryAddressOutOfRange = false;
  bool canSelectPaymentOption = true;
  Vendor vendor;
  CheckOut checkout;
  bool calculateTotal = true;

  //
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod selectedPaymentMethod;

  void initialise() async {
    fetchVendorDetails();
    prefetchDeliveryAddress();
    fetchPaymentOptions();
    updateTotalOrderSummary();
  }

  //
  fetchVendorDetails() async {
    //
    vendor = CartServices.productsInCart[0].product.vendor;

    //
    setBusy(true);
    try {
      vendor = await vendorRequest.vendorDetails(
        vendor.id,
        params: {
          "type": "brief",
        },
      );
      setVendorRequirement();
    } catch (error) {
      print("Error Getting Vendor Details ==> $error");
    }
    setBusy(false);
  }

  setVendorRequirement() {
    if (vendor.allowOnlyDelivery) {
      isPickup = false;
    } else if (vendor.allowOnlyPickup) {
      isPickup = true;
    }
  }

  //start of schedule related
  changeSelectedDeliveryDate(String string, int index) {
    checkout.deliverySlotDate = string;
    availableTimeSlots = vendor.deliverySlots[index].times;
    notifyListeners();
  }

  changeSelectedDeliveryTime(String time) {
    checkout.deliverySlotTime = time;
    notifyListeners();
  }

  //end of schedule related
  //
  prefetchDeliveryAddress() async {
    setBusyForObject(deliveryAddress, true);
    //
    try {
      //
      checkout.deliveryAddress = deliveryAddress =
          await deliveryAddressRequest.preselectedDeliveryAddress(
        vendorId: vendor.id,
      );

      //
      checkDeliveryRange();
      updateTotalOrderSummary();
    } catch (error) {
      print("Error Fetching preselected Address ==> $error");
    }
    setBusyForObject(deliveryAddress, false);
  }

  //
  fetchPaymentOptions() async {
    setBusyForObject(paymentMethods, true);
    try {
      paymentMethods = await paymentOptionRequest.getPaymentOptions(
        vendorId: vendor?.id,
      );
      //
      updatePaymentOptionSelection();
      clearErrors();
    } catch (error) {
      print("Error getting payment methods ==> $error");
    }
    setBusyForObject(paymentMethods, false);
  }

  //
  fetchTaxiPaymentOptions() async {
    setBusyForObject(paymentMethods, true);
    try {
      paymentMethods = await paymentOptionRequest.getTaxiPaymentOptions();
      //
      updatePaymentOptionSelection();
      clearErrors();
    } catch (error) {
      print("Error getting payment methods ==> $error");
    }
    setBusyForObject(paymentMethods, false);
  }

  updatePaymentOptionSelection() {
    if (checkout.total <= 0.00) {
      canSelectPaymentOption = false;
    } else {
      canSelectPaymentOption = true;
    }
    //
    if (!canSelectPaymentOption) {
      final selectedPaymentMethod = paymentMethods.firstWhere(
        (e) => e.isCash == 1,
        orElse: () => null,
      );
      if (selectedPaymentMethod != null) {
        changeSelectedPaymentMethod(selectedPaymentMethod, callTotal: false);
      }
    }
  }

  //
  showDeliveryAddressPicker() async {
    //
    await showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return DeliveryAddressPicker(
          onSelectDeliveryAddress: (deliveryAddress) {
            this.deliveryAddress = deliveryAddress;
            checkout.deliveryAddress = deliveryAddress;
            //
            checkDeliveryRange();
            updateTotalOrderSummary();
            //
            notifyListeners();
            viewContext.pop();
          },
        );
      },
    );
    return null;
  }

  //
  togglePickupStatus(bool value) {
    //
    if (vendor.allowOnlyPickup) {
      value = true;
    } else if (vendor.allowOnlyDelivery) {
      value = false;
    }
    isPickup = value;
    //remove delivery address if pickup
    if (isPickup) {
      checkout.deliveryAddress = null;
    } else {
      checkout.deliveryAddress = deliveryAddress;
    }

    updateTotalOrderSummary();
    notifyListeners();
  }

  //
  toggleScheduledOrder(bool value) async {
    isScheduled = value;
    checkout.isScheduled = isScheduled;
    //remove delivery address if pickup
    checkout.pickupDate = null;
    checkout.deliverySlotDate = "";
    checkout.pickupTime = null;
    checkout.deliverySlotTime = "";

    await Jiffy.locale(I18n.localeStr);

    notifyListeners();
  }

  //
  void checkDeliveryRange() {
    delievryAddressOutOfRange =
        vendor.deliveryRange < (deliveryAddress.distance ?? 0);
    if (deliveryAddress.can_deliver != null) {
      delievryAddressOutOfRange = !deliveryAddress.can_deliver;
    }
    notifyListeners();
  }

  //
  isSelected(PaymentMethod paymentMethod) {
    return selectedPaymentMethod != null &&
        paymentMethod.id == selectedPaymentMethod.id;
  }

  changeSelectedPaymentMethod(
    PaymentMethod paymentMethod, {
    bool callTotal = true,
  }) {
    selectedPaymentMethod = paymentMethod;
    checkout.paymentMethod = paymentMethod;
    if (callTotal) {
      updateTotalOrderSummary();
    }
    notifyListeners();
  }

  //update total/order amount summary
  updateTotalOrderSummary() async {
    //delivery fee
    if (!isPickup && deliveryAddress != null) {
      //selected delivery address is within range
      if (!delievryAddressOutOfRange) {
        //vendor charges per km
        setBusy(true);
        try {
          double orderDeliveryFee = await checkoutRequest.orderSummary(
            deliveryAddressId: deliveryAddress.id,
            vendorId: vendor.id,
          );

          //adding base fee
          checkout.deliveryFee = orderDeliveryFee;
        } catch (error) {
          if (vendor.chargePerKm != null && vendor.chargePerKm == 1) {
            checkout.deliveryFee =
                vendor.deliveryFee * deliveryAddress.distance;
          } else {
            checkout.deliveryFee = vendor.deliveryFee;
          }

          //adding base fee
          checkout.deliveryFee += vendor.baseDeliveryFee;
        }

        //
        setBusy(false);
      } else {
        checkout.deliveryFee = 0.00;
      }
    } else {
      checkout.deliveryFee = 0.00;
    }

    //tax
    checkout.tax = (double.parse(vendor.tax ?? "0") / 100) * checkout.subTotal;
    checkout.total = (checkout.subTotal - checkout.discount) +
        checkout.deliveryFee +
        checkout.tax;

    //
    updateCheckoutTotalAmount();
    updatePaymentOptionSelection();
    notifyListeners();
  }

  //
  bool pickupOnlyProduct() {
    //
    final product = CartServices.productsInCart.firstWhere(
      (e) => !e.product.canBeDelivered,
      orElse: () => null,
    );

    return product != null;
  }

  //
  updateCheckoutTotalAmount() {
    checkout.totalWithTip =
        checkout.total + (driverTipTEC.text.toDouble() ?? 0);
  }

  //
  placeOrder({bool ignore = false}) async {
    //
    if (isScheduled && checkout.deliverySlotDate.isEmptyOrNull) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery Date".i18n,
        text: "Please select your desire order date".i18n,
      );
    } else if (isScheduled && checkout.deliverySlotTime.isEmptyOrNull) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery Time".i18n,
        text: "Please select your desire order time".i18n,
      );
    } else if (!isPickup && pickupOnlyProduct()) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Product".i18n,
        text:
            "There seems to be products that can not be delivered in your cart"
                .i18n,
      );
    } else if (!isPickup && deliveryAddress == null) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery address".i18n,
        text: "Please select delivery address".i18n,
      );
    } else if (delievryAddressOutOfRange && !isPickup) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Delivery address".i18n,
        text: "Delivery address is out of vendor delivery range".i18n,
      );
    } else if (selectedPaymentMethod == null) {
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Payment Methods".i18n,
        text: "Please select a payment method".i18n,
      );
    } else if (!ignore && !verifyVendorOrderAmountCheck()) {
      print("Failed");
    }
    //process the new order
    else {
      processOrderPlacement();
    }
  }

  //
  processOrderPlacement() async {
    //process the order placement
    setBusy(true);
    //set the total with discount as the new total
    checkout.total = checkout.totalWithTip;
    //
    final apiResponse = await checkoutRequest.newOrder(
      checkout,
      tip: driverTipTEC.text,
      note: noteTEC.text,
    );
    //not error
    if (apiResponse.allGood) {
      //cash payment

      final paymentLink = apiResponse.body["link"].toString();
      if (!paymentLink.isEmptyOrNull) {
        viewContext.pop();
        showOrdersTab(context: viewContext);
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
              viewContext.pop(true);
              showOrdersTab(context: viewContext);
              if (viewContext.navigator.canPop()) {
                viewContext.navigator
                    .popUntil(ModalRoute.withName(AppRoutes.homeRoute));
              }
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
    setBusy(false);
  }

  //
  showOrdersTab({BuildContext context}) {
    //clear cart items
    CartServices.clearCart();
    //switch tab to orders
    AppService().changeHomePageIndex(index: 1);
    //pop until home page
    if (context != null) {
      context.navigator.popUntil(
        (route) {
          return route == AppRoutes.homeRoute || route.isFirst;
        },
      );
    }
  }

  //
  bool verifyVendorOrderAmountCheck() {
    //if vendor set min/max order
    final orderVendor = checkout?.cartItems?.first?.product?.vendor ?? vendor;
    //if order is less than the min allowed order by this vendor
    //if vendor is currently open for accepting orders

    if (!vendor.isOpen &&
        !(checkout.isScheduled ?? false) &&
        !(checkout.isPickup ?? false)) {
      //vendor is closed
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Vendor is not open".i18n,
        text: "Vendor is currently not open to accepting order at the moment"
            .i18n,
      );
      return false;
    } else if (orderVendor.minOrder != null &&
        orderVendor.minOrder > checkout.subTotal) {
      ///
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Minimum Order Value".i18n,
        text: "Order value/amount is less than vendor accepted minimum order"
                .i18n +
            "${AppStrings.currencySymbol} ${orderVendor.minOrder}",
      );
      return false;
    }
    //if order is more than the max allowed order by this vendor
    else if (orderVendor.maxOrder != null &&
        orderVendor.maxOrder < checkout.subTotal) {
      //
      CoolAlert.show(
        context: viewContext,
        type: CoolAlertType.error,
        title: "Maximum Order Value".i18n,
        text: "Order value/amount is more than vendor accepted maximum order"
                .i18n +
            "${AppStrings.currencySymbol} ${orderVendor.maxOrder}",
      );
      return false;
    }
    return true;
  }
}
