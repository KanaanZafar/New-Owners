import 'package:flutter/material.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/search.vm.dart';
import 'package:fuodz/views/pages/search/widget/search.header.dart';
import 'package:fuodz/views/pages/search/widget/vendor_search_header.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/grid_view_service.list_item.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor.list_item.dart';
import 'package:fuodz/widgets/states/search.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key, this.search, this.showCancel = true})
      : super(key: key);

  //
  final Search search;
  final bool showCancel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(context, search),
      builder: (context, model, child) {
        return BasePage(
          showCartView: showCancel,
          body: SafeArea(
            bottom: false,
            child: VStack(
              [
                //header
                SearchHeader(model, showCancel: showCancel),

                //Busy loading
                model.isBusy
                    ? BusyIndicator().centered()
                    : UiSpacer.emptySpace(),
                //tags
                VendorSearchHeaderview(model),

                //products
                CustomListView(
                  refreshController: model.refreshController,
                  canRefresh: true,
                  canPullUp: true,
                  onRefresh: model.startSearch,
                  onLoading: () => model.startSearch(initialLoaoding: false),
                  isLoading: model.isBusy,
                  dataSet: model.searchResults,
                  itemBuilder: (context, index) {
                    //
                    final searchResult = model.searchResults[index];
                    if (searchResult is Product) {
                      return HorizontalProductListItem(
                        searchResult,
                        onPressed: model.productSelected,
                        qtyUpdated: model.addToCartDirectly,
                      );
                    } else if (searchResult is Service) {
                      return GridViewServiceListItem(
                        service: searchResult,
                        onPressed: model.servicePressed,
                      );
                    } else {
                      return VendorListItem(
                        vendor: searchResult,
                        onPressed: model.vendorSelected,
                      );
                    }
                  },
                  separatorBuilder: (context, index) =>
                      UiSpacer.verticalSpace(space: 0),
                  emptyWidget: EmptySearch(),
                ).py12().expand(),
              ],
            ).pOnly(
              top: Vx.dp16,
              left: Vx.dp16,
              right: Vx.dp16,
            ),
          ),
        );
      },
    );
  }
}
