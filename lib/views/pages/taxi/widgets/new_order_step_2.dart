import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/views/pages/service/widgets/service_discount_section.dart';
import 'package:fuodz/views/pages/taxi/widgets/taxi_payment.item_view.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/buttons/custom_text_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/custom_masonry_grid_view.dart';
import 'package:fuodz/widgets/list_items/vehicle_type.list_item.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/taxi.i18n.dart';

class NewTaxiOrderStep2 extends StatelessWidget {
  const NewTaxiOrderStep2(this.vm, {Key key}) : super(key: key);
  final TaxiViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: MeasureSize(
        onChange: (size) {
          vm.updateGoogleMapPadding(height: size.height);
        },
        child: VStack(
          [
            //
            HStack(
              [
                //previous
                CustomTextButton(
                  padding: EdgeInsets.zero,
                  title: "Back".i18n,
                  onPressed: () => vm.closeOrderSummary(clear: false),
                ),
                UiSpacer.expandedSpace(),
                //cancel book
                CustomTextButton(
                  padding: EdgeInsets.zero,
                  title: "Cancel".i18n,
                  titleColor: Colors.red,
                  onPressed: vm.closeOrderSummary,
                ),
              ],
            ),
            //
            "Vehicle Type".i18n.text.semiBold.xl.make(),
            UiSpacer.verticalSpace(),
            //vehicle types
            CustomListView(
              scrollDirection: Axis.horizontal,
              dataSet: vm.vehicleTypes,
              isLoading: vm.busy(vm.vehicleTypes),
              itemBuilder: (context, index) {
                //
                final vehicleType = vm.vehicleTypes[index];
                //
                return VehicleTypeListItem(vm, vehicleType);
              },
            ).h(80),
            UiSpacer.verticalSpace(),
            //selected payment method
            "Payment".i18n.text.semiBold.xl.make(),
            UiSpacer.verticalSpace(space: 5),
            vm.busy(vm.paymentMethods)
                ? BusyIndicator().centered()
                : CustomMasonryGridView(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    items: vm.paymentMethods.map(
                      (paymentMethod) {
                        return TaxiPaymentItemView(
                          paymentMethod,
                          selected: (vm.selectedPaymentMethod != null) &&
                              (vm.selectedPaymentMethod.id == paymentMethod.id),
                          onselected: () {
                            vm.changeSelectedPaymentMethod(
                              paymentMethod,
                              callTotal: false,
                            );
                          },
                        );
                      },
                    ).toList(),
                  )
         

            ,
            UiSpacer.verticalSpace(),
            //discount section
            ServiceDiscountSection(vm, toggle: true),
            UiSpacer.verticalSpace(),
            SafeArea(
              top: false,
              child: Visibility(
                visible: vm.selectedVehicleType != null,
                child: CustomButton(
                  loading: vm.isBusy,
                  child: HStack(
                    [
                      "Order Now".i18n.text.make(),
                      " ".text.make(),
                      (vm.selectedVehicleType != null &&
                                  vm.selectedVehicleType.currency != null
                              ? vm.selectedVehicleType.currency.symbol
                              : AppStrings.currencySymbol)
                          .text
                          .semiBold
                          .xl
                          .make(),
                      "${vm.total.numCurrency}".text.semiBold.xl.make(),
                    ],
                  ),
                  onPressed: vm.selectedVehicleType != null
                      ? vm.processNewOrder
                      : null,
                ).wFull(context),
              ),
            ),
          ],
        )
            .p20()
            .scrollVertical()
            .box
            .color(context.backgroundColor)
            .topRounded(value: 30)
            .shadow5xl
            .make(),
      ),
    );
  }
}
