import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/views/pages/cart/cart.page.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/cart.i18n.dart';

class GoToCartView extends StatelessWidget {
  const GoToCartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        initialData: CartServices.productsInCart.length,
        stream: CartServices.cartItemsCountStream.stream,
        builder: (context, snapshot) {
          return Visibility(
            visible: snapshot.hasData && snapshot.data > 0,
            child: HStack(
              [
                //
                "You have %s in your cart"
                    .i18n
                    .fill([snapshot.data])
                    .text
                    .white
                    .make()
                    .expand(),
                //
                CustomButton(
                  title: "View Cart",
                  height: 20,
                  color: AppColor.accentColor,
                  elevation: 1,
                  onPressed: () {
                    context.push((context) => CartPage());
                  },
                ),
                //
              ],
            )
                .p20()
                .safeArea(top: false)
                .box
                .color(AppColor.primaryColor)
                .topRounded()
                .make(),
          );
        });
  }
}
