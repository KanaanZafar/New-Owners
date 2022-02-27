import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_details.vm.dart';
import 'package:fuodz/widgets/buttons/call.button.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/buttons/route.button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:fuodz/widgets/tags/close.tag.dart';
import 'package:fuodz/widgets/tags/delivery.tag.dart';
import 'package:fuodz/widgets/tags/open.tag.dart';
import 'package:fuodz/widgets/tags/pickup.tag.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor_details.i18n.dart';

class VendorDetailsHeader extends StatelessWidget {
  const VendorDetailsHeader(this.model, {this.showFeatureImage = true, Key key})
      : super(key: key);

  final VendorDetailsViewModel model;
  final bool showFeatureImage;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        VStack(
          [
            //vendor image
            showFeatureImage
                ? Hero(
                    tag: model.vendor.heroTag,
                    child: CustomImage(
                      imageUrl: model.vendor.featureImage,
                      height: 220,
                    ).wFull(context),
                  )
                : UiSpacer.emptySpace(),

            //vendor header
            VStack(
              [
                //vendor import details
                HStack(
                  [
                    //logo
                    CustomImage(
                      imageUrl: model.vendor.logo,
                      width: Vx.dp56,
                      height: Vx.dp56,
                    ).box.clip(Clip.antiAlias).withRounded(value: 5).make(),
                    //
                    VStack(
                      [
                        model.vendor.name.text.semiBold.lg.make(),
                        Visibility(
                          visible: model.vendor.address != null,
                          child: "${model.vendor.address ?? ''}"
                              .text
                              .light
                              .sm
                              .maxLines(1)
                              .make(),
                        ),
                        model.vendor.phone.text.light.sm.make(),
                      ],
                    ).pOnly(left: Vx.dp12).expand(),
                    //icons
                    VStack(
                      [
                        Visibility(
                          visible: model.vendor.address != null,
                          child: //location routing
                              (model.vendor.latitude != null &&
                                      model.vendor.longitude != null)
                                  ? RouteButton(model.vendor, size: 10)
                                  : UiSpacer.emptySpace(),
                        ),
                        UiSpacer.verticalSpace(space: 5),
                        //call button
                        (model.vendor.phone != null)
                            ? CallButton(model.vendor, size: 10)
                            : UiSpacer.emptySpace(),
                      ],
                    ).pOnly(left: Vx.dp12),
                  ],
                ),
              ],
            ).p8().card.make().p12(),
          ],
        ),

        //
        //
        VStack(
          [
            //tags
            HStack(
              [
                //rating
                HStack(
                  [
                    Icon(
                      FlutterIcons.star_ant,
                      size: 12,
                      color: Colors.yellow[800],
                    ).pOnly(right: 2),
                    model.vendor.rating.text.lg.make(),
                  ],
                  crossAlignment: CrossAxisAlignment.center,
                  alignment: MainAxisAlignment.center,
                ).pOnly(right: 20),

                //is open
                model.vendor.isOpen
                    ? OpenTag().pOnly(right: 10)
                    : CloseTag().pOnly(right: 10),

                //can deliveree
                model.vendor.delivery == 1
                    ? DeliveryTag().pOnly(right: 10)
                    : UiSpacer.emptySpace(),

                //can pickup
                model.vendor.pickup == 1
                    ? PickupTag().pOnly(right: 10)
                    : UiSpacer.emptySpace(),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ),
            UiSpacer.verticalSpace(space: 10),

            //description
            "Description".i18n.text.sm.bold.uppercase.make(),
            model.vendor.description.text.sm.make(),
            UiSpacer.verticalSpace(space: 10),
            //view reviews
            CustomButton(
              child: "View Reviews".i18n.text.sm.medium.white.makeCentered(),
              color: AppColor.accentColor,
              height: 30,
              onPressed: model.openVendorReviews,
            ),
          ],
        ).px20().py12(),
        UiSpacer.divider(),
        UiSpacer.verticalSpace(space: 10),
        //search bar
        CustomTextFormField(
          hintText: "Search".i18n,
          isReadOnly: true,
          onTap: model.openVendorSearch,
        ).px20(),
        UiSpacer.verticalSpace(space: 10),
        UiSpacer.divider(),
      ],
    );
  }
}
