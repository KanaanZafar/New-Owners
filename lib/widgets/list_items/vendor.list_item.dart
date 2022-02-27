import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/route.button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/tags/delivery.tag.dart';
import 'package:fuodz/widgets/tags/pickup.tag.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/top_vendor.i18n.dart';

class VendorListItem extends StatelessWidget {
  const VendorListItem({
    this.vendor,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Vendor vendor;
  final Function(Vendor) onPressed;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        Stack(
          children: [
            //
            Hero(
              tag: vendor.heroTag,
              child: CustomImage(
                imageUrl: vendor.featureImage,
                height: 60,
                width: context.screenWidth,
              ),
            ),
            //location routing
            (!vendor.latitude.isEmptyOrNull && !vendor.longitude.isEmptyOrNull)
                ? Positioned(
                    child: RouteButton(
                      vendor,
                      size: 12,
                    ),
                    bottom: 5,
                    right: 10,
                  )
                : UiSpacer.emptySpace(),

            //closed
            Positioned(
              child: Visibility(
                visible: !vendor.isOpen,
                child: VxBox(
                  child: "Closed".i18n.text.lg.white.bold.makeCentered(),
                )
                    .color(
                      AppColor.closeColor.withOpacity(0.6),
                    )
                    .make(),
              ),
              bottom: 0,
              right: 0,
              left: 0,
              top: 0,
            ),
          ],
        ),

        //name
        vendor.name.text.sm.medium
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .make()
            .px8()
            .pOnly(top: Vx.dp8),
        //
        //description
        "${vendor.description}"
            .text
            .coolGray400
            .minFontSize(9)
            .size(9)
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .make()
            .px8(),
        //
        HStack(
          [
            //rating
            HStack(
              [
                "${vendor.rating.numCurrency} "
                    .text
                    .minFontSize(6)
                    .size(10)
                    .color(AppColor.ratingColor)
                    .medium
                    .make(),
                Icon(
                  FlutterIcons.star_ent,
                  color: AppColor.ratingColor,
                  size: 10,
                ),
              ],
            ).expand(flex: 1),

            //
            //
            Visibility(
              visible: vendor.distance != null,
              child: HStack(
                [
                  Icon(
                    FlutterIcons.direction_ent,
                    color: AppColor.primaryColor,
                    size: 10,
                  ),
                  " ${vendor?.distance?.numCurrency}km"
                      .text
                      .minFontSize(6)
                      .size(10)
                      .make(),
                ],
              ).expand(flex: 2),
            ),

            //
            Visibility(
              visible: vendor.minOrder != null,
              child:
                  "${AppStrings.currencySymbol}${vendor.minOrder} - ${vendor.maxOrder} "
                      .text
                      .minFontSize(6)
                      .size(10)
                      .coolGray600
                      .medium
                      .maxLines(1)
                      .make()
                      .expand(flex: 2),
            ),
          ],
        ).px8(),

        //
        HStack(
          [
            //can deliver
            vendor.delivery == 1
                ? DeliveryTag().pOnly(right: 10)
                : UiSpacer.emptySpace(),

            //can pickup
            vendor.pickup == 1
                ? PickupTag().pOnly(right: 10)
                : UiSpacer.emptySpace(),
          ],
          crossAlignment: CrossAxisAlignment.end,
        ).p8()
      ],
    )
        .onInkTap(
          () => this.onPressed(this.vendor),
        )
        .w(context.percentWidth * 55)
        .card
        .clip(Clip.antiAlias)
        .withRounded(value: 5)
        .make();
  }
}
