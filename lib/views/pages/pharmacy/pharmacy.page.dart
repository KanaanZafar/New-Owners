import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/pharmacy.vm.dart';
import 'package:fuodz/views/pages/pharmacy/widgets/pharmacy_categories.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/best_selling_products.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/header.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/nearby_vendors.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/cards/view_all_vendors.view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage>
    with AutomaticKeepAliveClientMixin<PharmacyPage> {
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
              //
              VendorHeader(model: model),

              SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: model.refreshController,
                onRefresh: () {
                  model.refreshController.refreshCompleted();
                  setState(() {
                    pageKey = GlobalKey<State>();
                  });
                }, // model.reloadPage,
                child: VStack(
                  [
                    Banners(widget.vendorType),

                    //categories
                    PharmacyCategories(widget.vendorType),

                    //best selling
                    BestSellingProducts(widget.vendorType),

                    //nearby
                    NearByVendors(widget.vendorType),

                    //view cart and all vendors
                    ViewAllVendorsView(vendorType: widget.vendorType),
                  ],
                ).scrollVertical(),
              ).expand(),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
