import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

class VendorHeader extends StatefulWidget {
  const VendorHeader({
    Key key,
    this.model,
  }) : super(key: key);

  final MyBaseViewModel model;

  @override
  _VendorHeaderState createState() => _VendorHeaderState();
}

class _VendorHeaderState extends State<VendorHeader> {
  @override
  void initState() {
    super.initState();
    //
    if (widget.model.deliveryaddress.address == "Current Location") {
      widget.model.fetchCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        HStack(
          [
            //location icon
            Icon(
              FlutterIcons.location_pin_sli,
              size: 24,
            ).onInkTap(
              widget.model.useUserLocation,
            ),

            //
            VStack(
              [
                //
                HStack(
                  [
                    //
                    "Delivery Location".i18n.text.sm.semiBold.make(),
                    //
                    Icon(
                      FlutterIcons.chevron_down_fea,
                    ).px4(),
                  ],
                ),
                widget.model.deliveryaddress.address.text
                    .maxLines(1)
                    .ellipsis
                    .base
                    .make(),
              ],
            )
                .onInkTap(
                  widget.model.pickDeliveryAddress,
                )
                .px12()
                .expand(),
          ],
        ).expand(),

        // //
        // Icon(
        //   FlutterIcons.search1_ant,
        //   size: 14,
        //   color: Colors.white,
        // )
        //     .p4()
        //     .box
        //     .roundedFull
        //     .shadowSm
        //     .color(context.theme.colorScheme.secondary)
        //     .make()
        //     .onInkTap(
        //       widget.model.openSearch,
        //     ),

        //
        Icon(
          FlutterIcons.search_fea,
          size: 24,
        )
            .p8()
            .onInkTap(() {
              widget.model.openSearch();
            })
            .box
            .roundedSM
            .clip(Clip.antiAlias)
            .color(context.backgroundColor)
            .shadowXs
            .make(),
      ],
    ).p12();
  }
}
