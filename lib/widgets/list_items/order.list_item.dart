import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order.i18n.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({
    this.order,
    this.onPayPressed,
    this.orderPressed,
    Key key,
  }) : super(key: key);

  final Order order;
  final Function onPayPressed;
  final Function orderPressed;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HStack(
          [
            //
            VStack(
              [
                //
                HStack(
                  [
                    "#${order.code}".text.sm.medium.make().expand(),
                    "${AppStrings.currencySymbol} ${order.total.numCurrency}"
                        .text
                        .lg
                        .semiBold
                        .make(),
                  ],
                ),
                Divider(height: 4),

                //
                "${order.vendor.name}".text.lg.medium.make().py4(),
                //amount and total products
                HStack(
                  [
                    (order.isPackageDelivery
                            ? order.packageType.name
                            : order.isSerice
                                ? "${order.orderService.service.category.name}"
                                : "%s Product(s)"
                                    .i18n
                                    .fill([order.orderProducts.length ?? 0]))
                        .text
                        .sm
                        .medium
                        .make()
                        .expand(),
                    "${order.status}"
                        .i18n
                        .allWordsCapitilize()
                        .text
                        .sm
                        .color(
                          AppColor.getStausColor(order.status),
                        )
                        .medium
                        .make(),
                  ],
                ),
                //time & status
                HStack(
                  [
                    //time
                    Visibility(
                      visible: order.paymentMethod != null,
                      child:
                          "${order.paymentMethod?.name}".text.sm.medium.make(),
                    ).expand(),
                    "${order.formattedDate}".text.sm.make(),
                  ],
                ),
              ],
            ).p12().expand(),
          ],
        ),

        //
        //payment is pending
        order.isPaymentPending
            ? CustomButton(
                title: "PAY FOR ORDER".i18n,
                titleStyle: context.textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
                icon: FlutterIcons.credit_card_fea,
                iconSize: 18,
                onPressed: onPayPressed,
                shapeRadius: 0,
              )
            : UiSpacer.emptySpace(),
      ],
    )
        .box
        .border(color: Colors.grey[200])
        .make()
        .onInkTap(orderPressed)
        .card
        .elevation(0.5)
        .clip(Clip.antiAlias)
        .roundedSM
        .make();
  }
}
