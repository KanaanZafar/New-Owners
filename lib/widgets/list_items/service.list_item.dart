import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceListItem extends StatelessWidget {
  const ServiceListItem({
    this.service,
    this.onPressed,
    Key key,
  }) : super(key: key);

  final Function(Service) onPressed;
  final Service service;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //service image
        UiSpacer.horizontalSpace(space: 12),
        Hero(
          tag: service.heroTag,
          child: CustomImage(
            imageUrl: service.photos.isNotEmpty ? service.photos.first : "",
            boxFit: BoxFit.cover,
            width: context.percentWidth * 20,
            height: 80,
          ).box.roundedSM.clip(Clip.antiAlias).make(),
        ).py12(),

        VStack(
          [
            //name/title
            service.name.text.xl.medium.make(),
            //description and price
            "${service.description == null ? '...' : service.description} ${service.description}"
                .text
                .coolGray600
                .medium
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
            HStack(
              [
                "${AppStrings.currencySymbol}"
                    .text
                    .base
                    .light
                    .color(AppColor.primaryColor)
                    .make(),
                UiSpacer.horizontalSpace(space: 5),
                service.sellPrice.text.semiBold
                    .color(AppColor.primaryColor)
                    .xl
                    .make(),
                " ${service.durationText}".text.medium.xs.make(),
              ],
            ),
            //dsicount
            Visibility(
              visible: service.showDiscount,
              child: "- ${service.discountPercentage}%".text.red500.make(),
            ),

            UiSpacer.verticalSpace(space: 10),
          ],
        ).p12().expand(),
      ],
    )
        .box
        .withRounded(value: 10)
        .color(context.cardColor)
        .outerShadow
        .clip(Clip.antiAlias)
        .makeCentered()
        .onInkTap(
          () => this.onPressed(this.service),
        )
        .py4();
  }
}
