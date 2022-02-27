import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vehicle_type.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class VehicleTypeListItem extends StatelessWidget {
  const VehicleTypeListItem(
    this.vm,
    this.vehicleType, {
    Key key,
  }) : super(key: key);
  final VehicleType vehicleType;
  final TaxiViewModel vm;
  @override
  Widget build(BuildContext context) {
    //
    final selected = vm.selectedVehicleType != null &&
        vm.selectedVehicleType.id == vehicleType.id;

    //
    return VStack(
      [
        //
        CustomImage(
          imageUrl: vehicleType.photo,
          width: 30,
          height: 30,
        ),
        "${vehicleType.name}"
            .text
            .medium
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .make(),
        "${vehicleType.currency != null ? vehicleType.currency.symbol : AppStrings.currencySymbol}${vehicleType.total.numCurrency}"
            .text
            .medium
            .make(),
      ],
      alignment: MainAxisAlignment.center,
      // crossAlignment: CrossAxisAlignment.center,
    )
        .w(context.percentWidth * 20)
        .box
        .p4
        .px12
        .color(selected
            ? AppColor.primaryColor.withOpacity(0.15)
            : AppColor.primaryColor.withOpacity(0.01))
        .roundedSM
        .make()
        .onTap(
          () => vm.changeSelectedVehicleType(vehicleType),
        );
  }
}
