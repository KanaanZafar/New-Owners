import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/pharmacy.vm.dart';
import 'package:fuodz/views/pages/service/widgets/popular_services.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/complex_header.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/simple_styled_banners.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/top_rated_vendors.view.dart';
import 'package:fuodz/widgets/vendor_type_categories.view.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class ServicePage extends StatefulWidget {
  const ServicePage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage>
    with AutomaticKeepAliveClientMixin<ServicePage> {
  GlobalKey pageKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewModelBuilder<PharmacyViewModel>.reactive(
      viewModelBuilder: () => PharmacyViewModel(context, widget.vendorType),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: !AppStrings.isSingleVendorMode,
          elevation: 0,
          title: "${widget.vendorType.name}",
          appBarColor: context.theme.backgroundColor,
          appBarItemColor: AppColor.primaryColor,
          showCart: true,
          key: pageKey,
          body: VStack(
            [
              //banners
              SimpleStyledBanners(
                widget.vendorType,
                height: AppStrings.bannerHeight,
              ),
              //
              ComplexVendorHeader(model: model)
                  .box
                  .make(),

              //categories
              VendorTypeCategories(
                widget.vendorType,
                showTitle: false,
                description: "Categories",
                childAspectRatio: 1.4,
                crossAxisCount: 4,
                lessItemCount: 6,
              ),

              //top services
              PopularServicesView(widget.vendorType),
              //
              UiSpacer.verticalSpace(),
              //top vendors
              TopRatedVendors(widget.vendorType),

              //
              UiSpacer.verticalSpace(
                space: context.percentHeight * 20,
              ),
            ],
          ).scrollVertical(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
