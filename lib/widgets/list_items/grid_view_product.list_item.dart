import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/utils/utils.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/states/product_stock.dart';
import 'package:velocity_x/velocity_x.dart';

class GridViewProductListItem extends StatelessWidget {
  const GridViewProductListItem({
    this.product,
    this.onPressed,
    @required this.qtyUpdated,
    this.showStepper = false,
    Key key,
  }) : super(key: key);

  final Function(Product) onPressed;
  final Function(Product, int) qtyUpdated;
  final Product product;
  final bool showStepper;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        //product image
        Stack(
          children: [
            //
            Hero(
              tag: product.heroTag,
              child: CustomImage(
                imageUrl: product.photo,
                boxFit: BoxFit.cover,
                width: double.infinity,
                height: Vx.dp64 * 1.2,
              ),
            ),
            //
            //price tag
            Positioned(
              left: !Utils.isArabic ? 10 : null,
              right: !Utils.isArabic ? null : 10,
              child: Visibility(
                visible: product.showDiscount,
                child: VxBox(
                  child: "-${product.discountPercentage}%"
                      .text
                      .xs
                      .semiBold
                      .white
                      .make(),
                )
                    .p4
                    .bottomRounded(value: 5)
                    .color(AppColor.primaryColor)
                    .make(),
              ),
            ),
          ],
        ),

        //
        VStack(
          [
            product.name.text.semiBold.sm
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),
            product.vendor.name.text.xs
                .maxLines(1)
                .overflow(TextOverflow.ellipsis)
                .make(),

            //
            HStack(
              [
                //price
                HStack(
                  [
                    AppStrings.currencySymbol.text.xs.make(),
                    " ".text.make(),
                    product.sellPrice.numCurrency.text.sm.semiBold.make(),
                  ],
                ).expand(),
                //plus/min icon here
                showStepper
                    ? ProductStockState(product, qtyUpdated: qtyUpdated)
                    : UiSpacer.emptySpace(),
              ],
            ),
          ],
        ).p8(),
      ],
    )
        .box
        .withRounded(value: 5)
        .color(AppColor.accentColor.withOpacity(0.06))
        .clip(Clip.antiAlias)
        .outerShadowSm
        // .shadowOutline(
        //   outlineColor: AppColor.accentColor.withOpacity(0.001),
        // )
        .makeCentered()
        .onInkTap(
          () => this.onPressed(this.product),
        );
  }
}
