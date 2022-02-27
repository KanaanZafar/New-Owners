import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/taxi.vm.dart';
import 'package:fuodz/views/pages/taxi/widgets/new_order_step_1.dart';
import 'package:fuodz/views/pages/taxi/widgets/new_order_step_2.dart';
import 'package:fuodz/views/pages/taxi/widgets/taxi_rate_driver.view.dart';
import 'package:fuodz/views/pages/taxi/widgets/taxi_trip_ready.view.dart';
import 'package:fuodz/views/pages/taxi/widgets/trip_driver_search.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class TaxiPage extends StatefulWidget {
  const TaxiPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;

  @override
  _TaxiPageState createState() => _TaxiPageState();
}

class _TaxiPageState extends State<TaxiPage> with WidgetsBindingObserver {

  //
  TaxiViewModel taxiViewModel;

  @override
  void initState() {
    super.initState();
    taxiViewModel = TaxiViewModel(context, widget.vendorType);
  }
  //
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
     taxiViewModel?.googleMapController?.setMapStyle("[]");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaxiViewModel>.reactive(
      viewModelBuilder: () => taxiViewModel,
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: !AppStrings.isSingleVendorMode,
          elevation: 0,
          title: "${widget.vendorType.name}",
          appBarColor: context.theme.backgroundColor,
          appBarItemColor: AppColor.primaryColor,
          body: Stack(
            children: [
              //google map
              GoogleMap(
                initialCameraPosition: vm.mapCameraPosition,
                onMapCreated: vm.onMapCreated,
                padding: vm.googleMapPadding,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: vm.gMapMarkers,
                polylines: vm.gMapPolylines,
              ),

              //
              Visibility(
                visible: vm.currentStep(1),
                child: NewTaxiOrderStep1(vm),
              ),
              Visibility(
                visible: vm.currentStep(2),
                child: NewTaxiOrderStep2(vm),
              ),
              //
              Visibility(
                visible: vm.currentStep(3),
                child: TripDriverSearch(vm),
              ),
              //
              Visibility(
                visible: vm.currentStep(4),
                child: TaxiTripReadyView(vm),
              ),
              //
              Visibility(
                visible: vm.currentStep(6),
                child: TaxiRateDriverView(vm),
              ),
            ],
          ),
        );
      },
    );
  }
}
