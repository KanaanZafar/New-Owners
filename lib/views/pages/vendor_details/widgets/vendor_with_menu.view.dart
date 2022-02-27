import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_details.vm.dart';
import 'package:fuodz/views/pages/vendor_details/widgets/upload_prescription.btn.dart';
import 'package:fuodz/views/pages/vendor_details/widgets/vendor_details_header.view.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/custom_leading.dart';
import 'package:fuodz/widgets/cart_page_action.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorDetailsWithMenuPage extends StatefulWidget {
  VendorDetailsWithMenuPage({this.vendor, Key key}) : super(key: key);

  final Vendor vendor;

  @override
  _VendorDetailsWithMenuPageState createState() =>
      _VendorDetailsWithMenuPageState();
}

class _VendorDetailsWithMenuPageState extends State<VendorDetailsWithMenuPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () =>
          VendorDetailsViewModel(context, widget.vendor, tickerProvider: this),
      onModelReady: (model) {
        model.tabBarController =
            TabController(length: model.vendor.menus.length ?? 0, vsync: this);
        model.getVendorDetails();
      },
      builder: (context, model, child) {
        return Scaffold(
          floatingActionButton: UploadPrescriptionFab(model),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 220,
                  floating: false,
                  pinned: true,
                  leading: CustomLeading(),
                  actions: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: PageCartAction(),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(""),
                    background:
                        //vendor image
                        Hero(
                      tag: model.vendor.heroTag,
                      child: CustomImage(
                        imageUrl: model.vendor.featureImage,
                        height: 220,
                      ).wFull(context),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: VendorDetailsHeader(
                    model,
                    showFeatureImage: false,
                  ),
                ),
                SliverAppBar(
                  backgroundColor: context.theme.primaryColor,
                  title: "".text.make(),
                  floating: false,
                  pinned: true,
                  snap: false,
                  primary: false,
                  automaticallyImplyLeading: false,
                  flexibleSpace: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    indicatorWeight: 2,
                    controller: model.tabBarController,
                    tabs: model.vendor.menus.map(
                      (menu) {
                        return Tab(
                          text: menu.name,
                        );
                      },
                    ).toList(),
                  ),
                ),
              ];
            },
            body: Container(
              child: model.isBusy
                  ? BusyIndicator().p20().centered()
                  : TabBarView(
                      controller: model.tabBarController,
                      children: model.vendor.menus.map(
                        (menu) {
                          //
                          return CustomListView(
                            noScrollPhysics: true,
                            refreshController: model.getRefreshController(menu.id),
                            canPullUp: true,
                            canRefresh: true,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            dataSet: model.menuProducts[menu.id] ?? [],
                            isLoading: model.busy(menu.id),
                            onLoading: () => model.loadMoreProducts(
                              menu.id,
                              initialLoad: false,
                            ),
                            onRefresh: () => model.loadMoreProducts(menu.id),
                            itemBuilder: (context, index) {
                              //
                              final product =
                                  model.menuProducts[menu.id][index];
                              return HorizontalProductListItem(
                                product,
                                onPressed: model.productSelected,
                                qtyUpdated: model.addToCartDirectly,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                UiSpacer.verticalSpace(space: 5),
                          );
                        },
                      ).toList(),
                    ),
            ),
          ),
        );
      },
    );
  }
}
