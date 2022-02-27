import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/models/package_checkout.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/services/http.service.dart';

class CheckoutRequest extends HttpService {
  //
  Future<List<PaymentMethod>> getPaymentOptions() async {
    final apiResult = await get(Api.paymentMethods);

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return PaymentMethod.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }

  Future<ApiResponse> newOrder(
    CheckOut checkout, {
    String note = "",
    String tip = "",
  }) async {
    final apiResult = await post(
      Api.orders,
      {
        "tip": tip,
        "note": note,
        "coupon_code": checkout.coupon?.code ?? "",
        "pickup_date": checkout.deliverySlotDate,
        "pickup_time": checkout.deliverySlotTime,
        "products": checkout.cartItems,
        "vendor_id": checkout.cartItems.first.product.vendorId,
        "delivery_address_id": checkout.deliveryAddress?.id,
        "payment_method_id": checkout.paymentMethod.id,
        "sub_total": checkout.subTotal,
        "discount": checkout.discount,
        "delivery_fee": checkout.deliveryFee,
        "tax": checkout.tax,
        "total": checkout.total,
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> newPackageOrder(
    PackageCheckout packageCheckout, {
    String note,
  }) async {
    final apiResult = await post(
      Api.orders,
      {
        "type": "package",
        "note": note,
        "package_type_id": packageCheckout.packageType.id,
        "vendor_id": packageCheckout.vendor.id,
        "pickup_date": packageCheckout.date,
        "pickup_time": packageCheckout.time,
        "stops": packageCheckout.allStops != null
            ? packageCheckout.allStops.map((e) {
                return e.toJson();
              }).toList()
            : [],
        "recipient_name": packageCheckout.recipientName,
        "recipient_phone": packageCheckout.recipientPhone,
        "weight": packageCheckout.weight,
        "width": packageCheckout.width,
        "length": packageCheckout.length,
        "height": packageCheckout.height,
        "payment_method_id": packageCheckout.paymentMethod.id,
        "sub_total": packageCheckout.subTotal,
        "discount": packageCheckout.discount,
        "delivery_fee": packageCheckout.deliveryFee,
        "tax": packageCheckout.tax,
        "total": packageCheckout.total - packageCheckout.discount,
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  //
  Future<ApiResponse> newServiceOrder(
    CheckOut checkout, {
    Service service,
    String note,
  }) async {
    final apiResult = await post(
      Api.orders,
      {
        "type": "service",
        "note": note,
        "service_id": service.id,
        "vendor_id": service.vendor.id,
        "delivery_address_id": checkout.deliveryAddress.id,
        "pickup_date": checkout.pickupDate,
        "pickup_time": checkout.pickupTime,
        "hours": service.selectedQty,
        "service_price":
            service.showDiscount ? service.discountPrice : service.price,
        "payment_method_id": checkout.paymentMethod.id,
        "sub_total": checkout.subTotal,
        "discount": checkout.discount,
        "delivery_fee": checkout.deliveryFee,
        "tax": checkout.tax,
        "total": checkout.flexTotal,
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  Future<ApiResponse> newPrescriptionOrder(
    CheckOut checkout,
    Vendor vendor, {
    @required File photo,
    String note = "",
  }) async {
    final apiResult = await postWithFiles(
      Api.orders,
      {
        "type": vendor.vendorType.slug,
        "note": note,
        "pickup_date": checkout.deliverySlotDate,
        "pickup_time": checkout.deliverySlotTime,
        "vendor_id": vendor.id,
        "delivery_address_id": checkout.deliveryAddress?.id,
        "sub_total": checkout.subTotal,
        "discount": checkout.discount,
        "delivery_fee": checkout.deliveryFee,
        "tax": checkout.tax,
        "total": checkout.total,
        "photo": await MultipartFile.fromFile(
          photo.path,
        ),
      },
    );
    //
    return ApiResponse.fromResponse(apiResult);
  }

  Future<double> orderSummary({int deliveryAddressId, int vendorId}) async {
    final params = {
      "vendor_id": "${vendorId}",
      "delivery_address_id": "${deliveryAddressId}",
    };

    //
    final apiResult = await get(
      Api.generalOrderSummary,
      queryParameters: params,
    );

    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return PackageCheckout.fromJson(apiResponse.body).deliveryFee;
    }

    throw apiResponse.message;
  }
}
