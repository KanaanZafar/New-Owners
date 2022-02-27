import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';

class OrderPaymentInfoView extends StatelessWidget {
  const OrderPaymentInfoView(this.vm, {Key key}) : super(key: key);
  final OrderDetailsViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //payment is pending
        vm.order.isPaymentPending
            ? CustomButton(
                title: "PAY FOR ORDER".i18n,
                titleStyle: context.textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
                icon: FlutterIcons.credit_card_fea,
                iconSize: 18,
                onPressed: () => vm.openWebpageLink(vm.order.paymentLink),
              ).p20().pOnly(bottom: Vx.dp20)
            : UiSpacer.emptySpace(),
        //request payment
        (vm.order.paymentStatus == "request" && ["pending"].contains(vm.order.status))
            ? CustomButton(
                title: "PAY FOR ORDER".i18n,
                titleStyle: context.textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
                icon: FlutterIcons.credit_card_fea,
                iconSize: 18,
                loading: vm.busy(vm.order.paymentStatus),
                onPressed: vm.openPaymentMethodSelection,
              ).wFull(context).p20().pOnly(bottom: Vx.dp20)
            : UiSpacer.emptySpace(),
      ],
    );
  }
}
