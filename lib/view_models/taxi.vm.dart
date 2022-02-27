import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/coupon.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/models/vehicle_type.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/requests/cart.request.dart';
import 'package:fuodz/requests/payment_method.request.dart';
import 'package:fuodz/requests/taxi.request.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/view_models/trip_taxi.vm.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/taxi.i18n.dart';
import 'package:firebase_chat/models/chat_entity.dart';
import 'package:firebase_chat/models/peer_user.dart';

class TaxiViewModel extends TripTaxiViewModel {
  //
  TaxiViewModel(BuildContext context, this.vendorType) {
    this.viewContext = context;
  }

//requests
  CartRequest cartRequest = CartRequest();
  TaxiRequest taxiRequest = TaxiRequest();
  PaymentMethodRequest paymentOptionRequest = PaymentMethodRequest();
//

  VendorType vendorType;
  //coupons
  bool canApplyCoupon = false;
  Coupon coupon;
  TextEditingController couponTEC = TextEditingController();

  //
  CheckOut checkout = CheckOut();
  double subTotal = 0.0;
  double total = 0.0;
  double tip = 0.0;


  //functions
  void initialise() async {
    //
    fetchTaxiPaymentOptions();
    //
    getOnGoingTrip();
    //set current location as pickup location
    setupCurrentLocationAsPickuplocation();
  }

  //
  bool currentStep(int step) {
    return step == currentOrderStep;
  }

  isSelected(PaymentMethod paymentMethod) {
    return selectedPaymentMethod != null &&
        paymentMethod.id == selectedPaymentMethod.id;
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
        checkout.discount = (coupon.discount / 100) * checkout.subTotal;
      } else {
        checkout.discount = coupon.discount;
      }

      //
      calculateTotalAmount();
    } catch (error) {
      print("error ==> $error");
      setErrorForObject(coupon, error);
    }
    setBusyForObject(coupon, false);
  }

  

  //after locations has been selected
  proceedToStep2() {
    //validate user has selected both pickup and drop off location
    if (pickupLocation != null && dropoffLocation != null) {
      //
      prepareStep2();
    } else {
      toastError("Please select pickup and drop-off location".i18n);
    }
  }

  //
  void prepareStep2() {
    setCurrentStep(2);
    drawTripPolyLines();
    fetchVehicleTypes();
  }

  //vehicle types
  fetchVehicleTypes() async {
    setBusyForObject(vehicleTypes, true);
    try {
      vehicleTypes = await taxiRequest.getVehicleTypePricing(
        pickupLocation,
        dropoffLocation,
        countryCode: LocationService?.currenctAddress?.countryCode,
      );
    } catch (error) {
      print("Error getting vehicleTypes ==> $error");
    }
    setBusyForObject(vehicleTypes, false);
  }

  //
  changeSelectedVehicleType(VehicleType vehicleType) {
    selectedVehicleType = vehicleType;
    calculateTotalAmount();
  }

  //
  calculateTotalAmount() {
    subTotal = selectedVehicleType.total;
    total = subTotal - (checkout.discount ?? 0);
    notifyListeners();
  }

  //
  processNewOrder() async {
    //
    setBusy(true);
    final apiResponse = await taxiRequest.placeNeworder(
      params: {
        "payment_method_id": selectedPaymentMethod.id,
        "vehicle_type_id": selectedVehicleType.id,
        "pickup": {
          "lat": pickupLocation.latitude,
          "lng": pickupLocation.longitude,
          "address": pickupLocation.address,
        },
        "dropoff": {
          "lat": dropoffLocation.latitude,
          "lng": dropoffLocation.longitude,
          "address": dropoffLocation.address,
        },
        "sub_total": subTotal,
        "total": total,
        "discount": checkout.discount,
        "tip": tip,
        "coupon_code": coupon?.code,
        "vehicle_type": selectedVehicleType.encrypted,
      },
    );
    setBusy(false);

    //if there was an issue placing the order
    if (!apiResponse.allGood) {
      toastError(apiResponse.message);
    } else {
      //
      onGoingOrderTrip = Order.fromJson(apiResponse.body["order"]);
      //payment
      String paymentLink = apiResponse.body["link"];
      if (paymentLink.isNotBlank) {
        await openWebpageLink(paymentLink);
      }
      //
      startHandlingOnGoingTrip();
    }
  }

  //
  openTripChat() {
    //
    Map<String, PeerUser> peers = {
      '${onGoingOrderTrip.userId}': PeerUser(
        id: '${onGoingOrderTrip.userId}',
        name: onGoingOrderTrip.user.name,
        image: onGoingOrderTrip.user.photo,
      ),
      '${onGoingOrderTrip.driver.id}': PeerUser(
          id: "${onGoingOrderTrip.driver.id}",
          name: onGoingOrderTrip.driver.name,
          image: onGoingOrderTrip.driver.photo),
    };
    //
    final chatEntity = ChatEntity(
      mainUser: peers['${onGoingOrderTrip.userId}'],
      peers: peers,
      //don't translate this
      path: 'orders/' + onGoingOrderTrip.code + "/customerDriver/chats",
      title: "Chat with driver".i18n,
    );
    //
    viewContext.navigator.pushNamed(
      AppRoutes.chatRoute,
      arguments: chatEntity,
    );
  }
}
