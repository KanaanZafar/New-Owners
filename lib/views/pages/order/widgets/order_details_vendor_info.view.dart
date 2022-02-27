import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderDetailsVendorInfoView extends StatelessWidget {
  const OrderDetailsVendorInfoView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        HStack(
          [
            //
            VStack(
              [
                (!vm.order.isSerice ? "Vendor" : "Service Provider")
                    .i18n
                    .text
                    .gray500
                    .medium
                    .sm
                    .make(),
                vm.order.vendor.name.text.medium.xl
                    .make()
                    .py8()
                    .pOnly(bottom: Vx.dp4),
              ],
            ).expand(),
            //call
            vm.order.canChatVendor
                ? CustomButton(
                    icon: FlutterIcons.phone_call_fea,
                    iconColor: Colors.white,
                    color: AppColor.primaryColor,
                    shapeRadius: Vx.dp20,
                    onPressed: vm.callVendor,
                  ).wh(Vx.dp64, Vx.dp40).p12()
                : UiSpacer.emptySpace(),
          ],
        ),

        //chat
        vm.order.canChatVendor
            ? CustomButton(
                icon: FlutterIcons.chat_ent,
                iconColor: Colors.white,
                title: "Chat with %s".i18n.fill([(!vm.order.isSerice ? "Vendor" : "Service Provider")]),
                color: AppColor.primaryColor,
                onPressed: vm.chatVendor,
              ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
            : UiSpacer.emptySpace(),

        //rate vendor
        vm.order.canRateVendor
            ? CustomButton(
                icon: FlutterIcons.rate_review_mdi,
                iconColor: Colors.white,
                title: "Rate %s".i18n.fill([(!vm.order.isSerice ? "Vendor" : "Service Provider")]),
                color: AppColor.primaryColor,
                onPressed: vm.rateVendor,
              ).h(Vx.dp48).pOnly(top: Vx.dp12, bottom: Vx.dp20)
            : UiSpacer.emptySpace(),
      ],
    ).p12().card.make().p20();
  }
}
