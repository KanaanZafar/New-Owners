import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/recent_order.vm.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/order.list_item.dart';
import 'package:fuodz/widgets/states/empty.state.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/parcel.i18n.dart';

class RecentOrdersView extends StatelessWidget {
  const RecentOrdersView({Key key, this.vendorType}) : super(key: key);

  final VendorType vendorType;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecentOrderViewModel>.reactive(
      viewModelBuilder: () => RecentOrderViewModel(
        context,
        vendorType: vendorType,
      ),
      onModelReady: (vm) => vm.fetchMyOrders(),
      builder: (context, vm, child) {
        return VStack(
          [
            //
            "Recent Orders".i18n.text.make(),
            UiSpacer.verticalSpace(),
            //orders
            vm.isAuthenticated()
                ? CustomListView(
                    isLoading: vm.isBusy,
                    noScrollPhysics: true,
                    dataSet: vm.orders,
                    itemBuilder: (context, index) {
                      //
                      final order = vm.orders[index];
                      return OrderListItem(
                        order: order,
                        orderPressed: () => vm.openOrderDetails(order),
                        onPayPressed: () =>
                            vm.openWebpageLink(order.paymentLink),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        UiSpacer.verticalSpace(space: 2),
                  )
                : EmptyState(
                    auth: true,
                    showAction: true,
                    actionPressed: vm.openLogin,
                  ).py12().centered(),
          ],
        ).px20();
      },
    );
  }
}
