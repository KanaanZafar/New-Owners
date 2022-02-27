import 'package:flutter/material.dart';
import 'package:fuodz/models/order_product.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderProductListItem extends StatelessWidget {
  const OrderProductListItem({
    this.orderProduct,
    Key key,
  }) : super(key: key);

  final OrderProduct orderProduct;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //qty
        "x ${orderProduct.quantity}".text.semiBold.make(),
        VStack(
          [
            //
            orderProduct.product.name.text.light.make(),
            orderProduct.options != null
                ? orderProduct.options.text.sm.gray500.medium.make()
                : UiSpacer.emptySpace(),
          ],
        ).px12().expand(),
        "${AppStrings.currencySymbol}${orderProduct.price.numCurrency}"
            .text
            .light
            .make(),
        //
      ],
    );
  }
}
