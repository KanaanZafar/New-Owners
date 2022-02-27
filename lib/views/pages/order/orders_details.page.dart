import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/order.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/order_details.vm.dart';
import 'package:fuodz/views/pages/order/widgets/order.bottomsheet.dart';
import 'package:fuodz/views/pages/order/widgets/order_address.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_driver_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_items.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_details_vendor_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_payment_info.view.dart';
import 'package:fuodz/views/pages/order/widgets/order_status.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/cards/order_summary.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/order_details.i18n.dart';
import 'package:glass_kit/glass_kit.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({
    this.order,
    Key key,
    this.isOrderTracking = false,
  }) : super(key: key);

  //
  final Order order;
  final bool isOrderTracking;
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage>
    with WidgetsBindingObserver {
  //
  OrderDetailsViewModel vm;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && vm != null) {
      vm.fetchOrderDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    vm = OrderDetailsViewModel(context, widget.order);

    //
    return ViewModelBuilder<OrderDetailsViewModel>.reactive(
      viewModelBuilder: () => vm,
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          title: "Order Details".i18n,
          showAppBar: true,
          showLeadingAction: true,
          isLoading: vm.isBusy,
          onBackPressed: () {
            context.pop(vm.order);
          },
          //share button for parcel delivery order
          actions: vm.order.isPackageDelivery
              ? [
                  Icon(
                    FlutterIcons.share_2_fea,
                    color: Colors.white,
                  ).p8().onInkTap(vm.shareOrderDetails).p8(),
                ]
              : null,
          body: vm.isBusy
              ? BusyIndicator().centered()
              : Stack(
                  children: [
                    //vendor details
                    Positioned(
                      child: Stack(
                        children: [
                          //vendor feature image
                          CustomImage(
                            imageUrl: vm.order.vendor.featureImage,
                            width: double.infinity,
                            height: 200,
                          ),
                          //vendor details
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GlassContainer(
                              height: 200,
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.50),
                              borderGradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.60),
                                  Colors.white.withOpacity(0.10),
                                  AppColor.primaryColor.withOpacity(0.05),
                                  AppColor.primaryColor.withOpacity(0.6)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.0, 0.39, 0.40, 1.0],
                              ),
                              blur: 1.0,
                              borderWidth: 0,
                              elevation: 0,
                              isFrostedGlass: false,
                              shadowColor: Colors.black.withOpacity(0.20),
                              alignment: Alignment.center,
                              frostedOpacity: 0.12,
                              padding: EdgeInsets.all(8.0),
                              child: VStack(
                                [
                                  vm.order.vendor.name.text.white.xl3.semiBold
                                      .makeCentered(),
                                  UiSpacer.verticalSpace(space: 40)
                                ],
                                alignment: MainAxisAlignment.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    VStack(
                      [
                        UiSpacer.verticalSpace(space: 140),
                        VStack(
                          [
                            //free space
                            //header view
                            HStack(
                              [
                                //vendor logo
                                CustomImage(
                                  imageUrl: vm.order.vendor.logo,
                                  width: 50,
                                  height: 50,
                                ).box.roundedSM.clip(Clip.antiAlias).make(),
                                UiSpacer.horizontalSpace(),
                                //
                                VStack(
                                  [
                                    //
                                    "${vm.order.status.i18n.allWordsCapitilize() ?? vm.order.status.i18n}"
                                        .text
                                        .semiBold
                                        .xl
                                        .color(AppColor.getStausColor(
                                            vm.order.status))
                                        .make(),
                                    "${Jiffy(vm.order.updatedAt).format('MMM dd, yyyy \| HH:mm')}"
                                        .text
                                        .light
                                        .lg
                                        .make(),
                                    "#${vm.order.code}"
                                        .text
                                        .xs
                                        .gray400
                                        .light
                                        .make(),
                                  ],
                                ).expand(),
                                //qr code icon
                                Visibility(
                                  visible:
                                      !vm.order.isTaxi && !vm.order.isSerice,
                                  child: Icon(
                                    FlutterIcons.qrcode_ant,
                                    size: 28,
                                  ).onInkTap(vm.showVerificationQRCode),
                                ),
                              ],
                            ).p20().wFull(context),
                            //
                            UiSpacer.cutDivider(),
                            //Payment status
                            OrderPaymentInfoView(vm),
                            //status
                            Visibility(
                              visible: vm.order.showStatusTracking,
                              child: VStack(
                                [
                                  OrderStatusView(vm).p20(),
                                  UiSpacer.divider(),
                                ],
                              ),
                            ),
                            // either products/package details
                            OrderDetailsItemsView(vm).p20(),
                            //show package delivery addresses
                            Visibility(
                              visible: vm.order.deliveryAddress != null,
                              child: OrderAddressesView(vm).p20(),
                            ),
                            //
                            (!vm.order.isPackageDelivery &&
                                    vm.order.deliveryAddress == null)
                                ? "Customer Order Pickup"
                                    .i18n
                                    .text
                                    .lg
                                    .medium
                                    .make()
                                    .px20()
                                    .pOnly(bottom: Vx.dp20)
                                : UiSpacer.emptySpace(),

                            //note
                            "Note".i18n.text.semiBold.xl.make().px20(),
                            "${vm.order.note}".text.light.sm.make().px20(),
                            UiSpacer.verticalSpace(),

                            UiSpacer.cutDivider(),
                            //vendor
                            OrderDetailsVendorInfoView(vm),

                            //driver
                            OrderDetailsDriverInfoView(vm),

                            UiSpacer.cutDivider(color: Vx.coolGray200),
                            //order summary
                            OrderSummary(
                              subTotal: vm.order.subTotal,
                              discount: vm.order.discount,
                              deliveryFee: vm.order.deliveryFee,
                              tax: vm.order.tax,
                              driverTip: vm.order.tip,
                              vendorTax: ((vm.order.tax / vm.order.subTotal) * 100)
                                  .toDoubleStringAsFixed(),
                              total: vm.order.total,
                            )
                                .wFull(context)
                                .p20()
                                .pOnly(bottom: context.percentHeight * 10)
                                .box
                                .make()
                          ],
                        )
                            .box
                            .topRounded(value: 15)
                            .clip(Clip.antiAlias)
                            .color(context.backgroundColor)
                            .make(),
                      ],
                    ).scrollVertical(),
                  ],
                ),
          bottomSheet: widget.isOrderTracking ? null : OrderBottomSheet(vm),
        );
      },
    );
  }
}
