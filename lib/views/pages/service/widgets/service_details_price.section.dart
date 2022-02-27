import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/services.i18n.dart';

class ServiceDetailsPriceSectionView extends StatelessWidget {
  const ServiceDetailsPriceSectionView(this.service, {this.onlyPrice = false, Key key})
      : super(key: key);

  final Service service;
  final bool onlyPrice;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        "${AppStrings.currencySymbol}"
            .text
            .xl
            .medium
            .color(AppColor.primaryColor)
            .make(),
        service.price.text.semiBold.color(AppColor.primaryColor).xl2.make(),
        " ${ service.durationText }".text.medium.xl.make(),
        UiSpacer.horizontalSpace(space: 5),
        //discount
        Visibility(
          visible: !onlyPrice,
          child: service.showDiscount
              ? "${AppStrings.currencySymbol}${service.price - service.discountPrice} ${'Off'.i18n}"
                  .text
                  .white
                  .semiBold
                  .make()
                  .p2()
                  .px4()
                  .box
                  .red500
                  .roundedLg
                  .make()
              : UiSpacer.emptySpace(),
        ),
        //
        UiSpacer.emptySpace().expand(),
        //rating
        Visibility(
          visible: !onlyPrice,
          child: VxRating(
            value: double.parse((service?.vendor?.rating ?? 5.0).toString()),
            count: 5,
            isSelectable: false,
            onRatingUpdate: null,
            selectionColor: AppColor.ratingColor,
            normalColor: Colors.grey,
            size: 18,
          ),
        ),
      ],
    );
  }
}
