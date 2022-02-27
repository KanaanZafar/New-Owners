import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/app.service.dart';
import 'package:fuodz/translations/search.i18n.dart';
import 'package:fuodz/view_models/search.vm.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorSearchHeaderview extends StatelessWidget {
  const VendorSearchHeaderview(this.model, {Key key}) : super(key: key);

  final SearchViewModel model;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        (model.vendorType != null && model.vendorType.isService)
            ? "Services"
                .i18n
                .text
                .color(model.filterByProducts
                    ? Colors.white
                    : context.textTheme.bodyText1.color)
                .make()
                .py4()
                .px12()
                .box
                .roundedLg
                // .border(color: Colors.grey)
                .border(
                    color: model.filterByProducts ? Colors.white : Colors.grey)
                .color(model.filterByProducts
                    ? AppColor.primaryColor
                    : context.cardColor)
                .makeCentered()
                .pOnly(
                  right: AppService.isDirectionRTL(context) ? Vx.dp0 : Vx.dp12,
                  left: AppService.isDirectionRTL(context) ? Vx.dp12 : Vx.dp0,
                )
                .onInkTap(model.enableProductFilter)
            : "Products"
                .i18n
                .text
                .color(model.filterByProducts
                    ? Colors.white
                    : context.textTheme.bodyText1.color)
                .make()
                .py4()
                .px12()
                .box
                .roundedLg
                // .border(color: Colors.grey)
                .border(
                    color: model.filterByProducts ? Colors.white : Colors.grey)
                .color(model.filterByProducts
                    ? AppColor.primaryColor
                    : context.cardColor)
                .makeCentered()
                .pOnly(
                  right: AppService.isDirectionRTL(context) ? Vx.dp0 : Vx.dp12,
                  left: AppService.isDirectionRTL(context) ? Vx.dp12 : Vx.dp0,
                )
                .onInkTap(model.enableProductFilter),

        //vendor
        Visibility(
          visible: !AppStrings.enableSingleVendor,
          child: (model.vendorType != null && model.vendorType.isService)
              ? "Providers"
                  .i18n
                  .text
                  .color(!model.filterByProducts
                      ? Colors.white
                      : context.textTheme.bodyText1.color)
                  .make()
                  .py4()
                  .px12()
                  .box
                  .roundedLg
                  .border(
                      color: !model.filterByProducts ? Colors.white : Colors.grey)
                  .color(!model.filterByProducts
                      ? AppColor.primaryColor
                      : context.cardColor)
                  .makeCentered()
                  .onInkTap(model.enableVendorFilter)
              : "Vendors"
                  .i18n
                  .text
                  .color(!model.filterByProducts
                      ? Colors.white
                      : context.textTheme.bodyText1.color)
                  .make()
                  .py4()
                  .px12()
                  .box
                  .roundedLg
                  .border(
                      color: !model.filterByProducts ? Colors.white : Colors.grey)
                  .color(!model.filterByProducts
                      ? AppColor.primaryColor
                      : context.cardColor)
                  .makeCentered()
                  .onInkTap(model.enableVendorFilter),
        ),
      ],
    ).py12();
  }
}
