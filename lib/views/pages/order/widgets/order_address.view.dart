import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_images.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/widgets/list_items/parcel_order_stop.list_view.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderAddressesView extends StatelessWidget {
  const OrderAddressesView(this.vm, {Key key}) : super(key: key);

  final OrderDetailsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        vm.order.isPackageDelivery
            ? VStack(
                [
                  //
                  ParcelOrderStopListView(
                    "Pickup Location",
                    vm.order.orderStops.first,
                    canCall: vm.order.canChatVendor,
                  ),

                  //stops
                  ...stopsList(),
                  //
                  ParcelOrderStopListView(
                    "Dropoff Location",
                    vm.order.orderStops.last,
                    canCall: vm.order.canChatVendor,
                  ),
                ],
              )
            : UiSpacer.emptySpace(),

        //regular delivery address
        Visibility(
          visible: !vm.order.isPackageDelivery,
          child: VStack(
            [
              "Delivery details".i18n.text.xl.semiBold.make(),
              //vendor address
              HStack(
                [
                  //
                  Image.asset(
                    AppImages.pickupLocation,
                    width: 15,
                    height: 15,
                  ),
                  UiSpacer.smHorizontalSpace(),
                  //
                  VStack(
                    [
                      vm.order.vendor.address != null
                          ? vm.order.vendor.address.text.make()
                          : UiSpacer.emptySpace(),
                    ],
                  ).expand(),
                ],
                crossAlignment: CrossAxisAlignment.start,
              ).py12(),
              //delivery address
              Visibility(
                visible: vm.order.deliveryAddress != null,
                child: HStack(
                  [
                    //
                    Image.asset(
                      AppImages.dropoffLocation,
                      width: 15,
                      height: 15,
                    ),
                    UiSpacer.smHorizontalSpace(),
                    //
                    VStack(
                      [
                        vm.order.deliveryAddress != null
                            ? vm.order.deliveryAddress.address.text.make()
                            : UiSpacer.emptySpace(),
                        vm.order.deliveryAddress != null
                            ? vm.order.deliveryAddress.name.text
                                .color(Vx.coolGray400)
                                .sm
                                .light
                                .make()
                            : UiSpacer.emptySpace(),
                      ],
                    ).expand(),
                  ],
                  crossAlignment: CrossAxisAlignment.start,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //
  List<Widget> stopsList() {
    List<Widget> stopViews = [];
    if (vm.order.orderStops.length > 2) {
      stopViews = vm.order.orderStops
          .sublist(1, vm.order.orderStops.length - 1)
          .mapIndexed((stop, index) {
        return VStack(
          [
            ParcelOrderStopListView(
              "Stop".i18n + " ${index + 1}",
              stop,
              canCall: vm.order.canChatVendor,
            ),
          ],
        );
      }).toList();
    } else {
      stopViews.add(UiSpacer.emptySpace());
    }

    return stopViews;
  }
}
