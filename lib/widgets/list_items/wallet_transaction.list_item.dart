import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/wallet_transaction.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:fuodz/translations/wallet.i18n.dart';

class WalletTransactionListItem extends StatelessWidget {
  const WalletTransactionListItem(this.walletTransaction, {Key key})
      : super(key: key);

  final WalletTransaction walletTransaction;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        UiSpacer.verticalSpace(space: 5),
        HStack(
          [
            "${walletTransaction.status.isEmpty ? 'Error' : walletTransaction.status ?? 'Error'}"
                .i18n
                .allWordsCapitilize()
                .text
                .medium
                .sm
                .color(AppColor.getStausColor(walletTransaction.status))
                .make()
                .expand(),
            "${walletTransaction.isCredit == 1 ? '+' : '-'} ${AppStrings.currencySymbol} ${walletTransaction.amount.numCurrency}"
                .text
                .semiBold
                .lg
                .color(
                    walletTransaction.isCredit == 1 ? Colors.green : Colors.red)
                .make()
          ],
        ),
        //
        HStack(
          [
            "${walletTransaction.reason != null ? walletTransaction.reason : ''}"
                .text
                .sm
                .make()
                .expand(),
            "${DateFormat.MMMd(I18n.localeStr).format(walletTransaction.createdAt)}"
                .text
                .light
                .make()
          ],
        ),
      ],
    )
        .p8()
        .box
        .outerShadow
        .color(context.cardColor)
        .withRounded(value: 1)
        .clip(Clip.antiAlias)
        .make()
        .px2();
  }
}
