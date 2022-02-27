import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/vendor/popular_services.vm.dart';
import 'package:fuodz/widgets/buttons/custom_outline_button.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/service.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/services.i18n.dart';

class PopularServicesView extends StatefulWidget {
  const PopularServicesView(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;

  @override
  _PopularServicesViewState createState() => _PopularServicesViewState();
}

class _PopularServicesViewState extends State<PopularServicesView> {
  bool showGrid = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PopularServicesViewModel>.reactive(
      viewModelBuilder: () => PopularServicesViewModel(
        context,
        widget.vendorType,
      ),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            //
            ("Popular".i18n + " ${widget.vendorType.name}")
                .text
                .lg
                .medium
                .make()
                .px12(),

            //
            CustomListView(
              noScrollPhysics: true,
              isLoading: vm.isBusy,
              dataSet: vm.services,
              itemBuilder: (context, index) {
                final service = vm.services[index];
                return ServiceListItem(
                  service: service,
                  onPressed: vm.serviceSelected,
                );
              },
            ).p12(),

            //view more
            CustomOutlineButton(
              height: 24,
              child: "View More"
                  .i18n
                  .text
                  .medium
                  .sm
                  .color(AppColor.primaryColor)
                  .makeCentered(),
              titleStyle: context.textTheme.bodyText1.copyWith(
                color: AppColor.primaryColor,
              ),
              onPressed: vm.openSearch,
            ).px20(),
          ],
        ).py12();
      },
    );
  }
}
