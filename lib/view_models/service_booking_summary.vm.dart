import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/coupon.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/requests/cart.request.dart';
import 'package:fuodz/requests/payment_method.request.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/checkout_base.vm.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/checkout.i18n.dart';

class ServiceBookingSummaryViewModel extends CheckoutBaseViewModel {
  //
  ServiceBookingSummaryViewModel(BuildContext context, this.service) {
    this.viewContext = context;
    vendor = service.vendor;
    fetchPaymentOptions();

    //prepare checkout
    checkout = CheckOut();
    final subTotal = double.parse(
        ((service.showDiscount ? service.discountPrice : service.price) *
                (service.isPerHour ? (service.selectedQty ?? 1) : 1))
            .toString());
    checkout.subTotal = subTotal;
  }
//
  CartRequest cartRequest = CartRequest();
  PaymentMethodRequest paymentOptionRequest = PaymentMethodRequest();
  TextEditingController noteTEC = TextEditingController();
  //coupons
  bool canApplyCoupon = false;
  Coupon coupon;
  TextEditingController couponTEC = TextEditingController();

  //
  CheckOut checkout = CheckOut();
  Service service;
  double subTotal = 0.0;
  double total = 0.0;
  final currencySymbol = AppStrings.currencySymbol;
  //
  List<PaymentMethod> paymentMethods = [];
  PaymentMethod selectedPaymentMethod;

  //get payment options
  fetchPaymentOptions() async {
    setBusyForObject(paymentMethods, true);
    try {
      paymentMethods = await paymentOptionRequest.getPaymentOptions(
        vendorId: service.vendor.id,
      );
      //
      clearErrors();
    } catch (error) {
      print("Error getting payment methods ==> $error");
    }
    setBusyForObject(paymentMethods, false);
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
    } catch (error) {
      print("error ==> $error");
      setErrorForObject(coupon, error);
    }
    setBusyForObject(coupon, false);
  }

  //
  //
  processOrderPlacement() async {
    //process the order placement
    setBusy(true);
    //set the total with discount as the new total
    checkout.total = checkout.totalWithTip;
    //
    final apiResponse = await checkoutRequest.newServiceOrder(
      checkout,
      service: service,
      note: noteTEC.text,
    );
    //not error
    if (apiResponse.allGood) {
      //cash payment

      final paymentLink = apiResponse.body["link"].toString();
      if (!paymentLink.isEmptyOrNull) {
        viewContext.pop();
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
              showOrdersTab();
              viewContext.pop(true);
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
}
