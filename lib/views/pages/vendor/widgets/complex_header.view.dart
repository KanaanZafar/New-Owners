import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

class ComplexVendorHeader extends StatelessWidget {
  const ComplexVendorHeader({
    Key key,
    this.model,
  }) : super(key: key);

  final MyBaseViewModel model;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //location icon
        Icon(
          FlutterIcons.location_pin_sli,
          size: 24,
        ).onInkTap(
          model.useUserLocation,
        ),

        //
        VStack(
          [
            //
            "Delivery Location".i18n.text.lg.semiBold.make(),
            model.deliveryaddress.address.text.base.maxLines(1).make(),
          ],
        )
            .onInkTap(
              model.pickDeliveryAddress,
            )
            .px12()
            .expand(),

        //
        //
        Icon(
          FlutterIcons.search_fea,
          size: 24,
        )
            .p8()
            .onInkTap(() {
              model.openSearch();
            })
            .box
            .roundedSM
            .clip(Clip.antiAlias)
            .color(context.backgroundColor)
            .shadowXs
            .make(),
      ],
    ).p8().px16().py8();
  }
}
