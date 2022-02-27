import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/grocery.vm.dart';
import 'package:fuodz/views/pages/grocery/widgets/grocery_categories.view.dart';
import 'package:fuodz/views/pages/grocery/widgets/grocery_picks.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/header.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/nearby_vendors.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/cards/view_all_vendors.view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _GroceryPageState createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage>
    with AutomaticKeepAliveClientMixin<GroceryPage> {
  GlobalKey pageKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      showAppBar: true,
      showLeadingAction: !AppStrings.isSingleVendorMode,
      elevation: 0,
      title: "${widget.vendorType.name}",
      appBarColor: context.theme.backgroundColor,
      appBarItemColor: AppColor.primaryColor,
      showCart: true,
      key: pageKey,
      body: ViewModelBuilder<GroceryViewModel>.reactive(
        viewModelBuilder: () => GroceryViewModel(context, widget.vendorType),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return VStack(
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
                    //banners
                    Banners(widget.vendorType),
                    //categories
                    GroceryCategories(widget.vendorType),

                    //nearby
                    NearByVendors(widget.vendorType),

                    //today picks
                    GroceryPicksView(model),

                    //view cart and all vendors
                    ViewAllVendorsView(vendorType: widget.vendorType),
                  ],
                ).scrollVertical(),
              ).expand(),
            ],
            // key: model.pageKey,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
