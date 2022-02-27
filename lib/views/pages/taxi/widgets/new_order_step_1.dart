import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:measure_size/measure_size.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/taxi.i18n.dart';

class NewTaxiOrderStep1 extends StatelessWidget {
  const NewTaxiOrderStep1(this.vm, {Key key}) : super(key: key);
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
        child: vm.isBusy
            ? BusyIndicator().centered()
            : VStack(
                [
                  //
                  "Where to?".i18n.text.medium.xl2.make(),
                  UiSpacer.verticalSpace(),
                  //from
                  CustomTextFormField(
                    textEditingController: vm.pickupLocationTEC,
                    hintText: "Pickup Location".i18n,
                    isReadOnly: true,
                    maxLines: 1,
                    prefixIcon: Icon(
                      FlutterIcons.circle_double_mco,
                      size: 16,
                      color: AppColor.getStausColor("pending"),
                    ),
                    onTap: () => vm.openLocationSelector(1),
                  ),
                  UiSpacer.verticalSpace(),
                  CustomTextFormField(
                    textEditingController: vm.dropoffLocationTEC,
                    hintText: "Drop-off Location".i18n,
                    isReadOnly: true,
                    maxLines: 1,
                    prefixIcon: Icon(
                      FlutterIcons.stop_circle_fea,
                      size: 16,
                      color: AppColor.getStausColor("delivered"),
                    ),
                    onTap: () => vm.openLocationSelector(2),
                  ),
                  UiSpacer.verticalSpace(),
                  SafeArea(
                    top: false,
                    child: CustomButton(
                      child: "Next".i18n.text.makeCentered(),
                      onPressed: vm.proceedToStep2,
                    ).wFull(context),
                  ),
                ],
              )
                .p20()
                .box
                .color(context.backgroundColor)
                .topRounded()
                .shadow5xl
                .make(),
      ),
    );
  }
}
