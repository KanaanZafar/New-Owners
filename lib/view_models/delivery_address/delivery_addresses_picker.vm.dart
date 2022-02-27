import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/requests/delivery_address.request.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class DeliveryAddressPickerViewModel extends MyBaseViewModel {
  //
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  List<DeliveryAddress> deliveryAddresses = [];
  final Function(DeliveryAddress) onSelectDeliveryAddress;

  //
  DeliveryAddressPickerViewModel(
      BuildContext context, this.onSelectDeliveryAddress) {
    this.viewContext = context;
  }

  //
  void initialise() {
    //
    fetchDeliveryAddresses();
  }

  //
  fetchDeliveryAddresses() async {
    //
    final vendorId = CartServices.productsInCart.isNotEmpty
        ? CartServices.productsInCart.first.product.vendor.id
        : null;

    setBusy(true);
    try {
      deliveryAddresses = await deliveryAddressRequest.getDeliveryAddresses(
        vendorId: vendorId,
      );
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  //
  newDeliveryAddressPressed() async {
    await viewContext.navigator.pushNamed(
      AppRoutes.newDeliveryAddressesRoute,
    );
    fetchDeliveryAddresses();
  }

  //
  void pickFromMap() async {
    //
    PickResult locationResult = await newPlacePicker();

    if (locationResult != null) {
      DeliveryAddress deliveryAddress = DeliveryAddress();
      deliveryAddress.address = locationResult.formattedAddress;
      deliveryAddress.latitude = locationResult.geometry.location.lat;
      deliveryAddress.longitude = locationResult.geometry.location.lng;
      // From coordinates
      setBusy(true);
      final coordinates = new Coordinates(
        deliveryAddress.latitude,
        deliveryAddress.longitude,
      );
      //
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates,
      );
      deliveryAddress.city = addresses.first.locality;
      setBusy(false);
      //
      this.onSelectDeliveryAddress(deliveryAddress);
    }
  }
}
