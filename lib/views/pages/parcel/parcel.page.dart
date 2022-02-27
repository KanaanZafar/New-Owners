import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/new_parcel.page.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
import 'package:fuodz/widgets/recent_orders.view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/parcel.i18n.dart';

class ParcelPage extends StatefulWidget {
  ParcelPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;

  @override
  _ParcelPageState createState() => _ParcelPageState();
}

class _ParcelPageState extends State<ParcelPage> {
  GlobalKey pageKey = GlobalKey<State>();

  //
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ParcelViewModel>.reactive(
      viewModelBuilder: () =>
          ParcelViewModel(context, vendorType: widget.vendorType),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: !AppStrings.isSingleVendorMode,
          elevation: 0,
          showCart: true,
          title: "${vm.vendorType.name}",
          appBarColor: AppColor.primaryColor,
          appBarItemColor: context.theme.backgroundColor,
          key: pageKey,
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: vm.refreshController,
            onRefresh: () {
              vm.refreshController.refreshCompleted();
              setState(() {
                pageKey = GlobalKey<State>();
              });
            },
            child: VStack(
              [
                //header
                VStack(
                  [
                    //
                    "Track your package".i18n.text.semiBold.white.xl4.make(),
                    //
                    CustomTextFormField(
                      // labelText: "Order Code",
                      isReadOnly: vm.isBusy,
                      hintText: "Search by order code".i18n,
                      onFieldSubmitted: vm.trackOrder,
                      fillColor: context.brightness != Brightness.dark ? Colors.white: Colors.grey[600],
                      //loading and scan icon
                      // suffixIcon: !vm.isBusy
                      //     ? Icon(
                      //         FlutterIcons.scan1_ant,
                      //       ).p4().onInkTap(vm.openCodeScanner)
                      //     : BusyIndicator(
                      //         color: AppColor.primaryColor,
                      //       ).p8(),
                    ).py12(),
                  ],
                ).p20().box.color(AppColor.primaryColor).make(),

                //
                UiSpacer.verticalSpace(),
                VendorTypeListItem(
                  vm.vendorType,
                  onPressed: () {
                    //open the new parcel page
                    context.nextPage(NewParcelPage(widget.vendorType));
                  },
                ).px20(),

                //recent orders
                UiSpacer.verticalSpace(),
                RecentOrdersView(vendorType: widget.vendorType),
                UiSpacer.verticalSpace(),
              ],
            ).scrollVertical(),
          ),
        );
      },
    );
  }
}
