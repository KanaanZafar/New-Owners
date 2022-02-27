import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/vendor/categories.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/translations/vendor/vendor_type_view.i18n.dart';
import 'package:fuodz/widgets/custom_grid_view.dart';
import 'package:fuodz/widgets/list_items/category.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({this.vendorType, Key key}) : super(key: key);

  final VendorType vendorType;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () =>
          CategoriesViewModel(context, vendorType: vendorType),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showCart: true,
          showLeadingAction: true,
          title: "Categories".i18n,
          body: VStack(
            [
              CustomGridView(
                crossAxisCount: 4,
                refreshController: vm.refreshController,
                canPullUp: true,
                canRefresh: true,
                onLoading: vm.loadMoreItems,
                onRefresh: () => vm.loadMoreItems(true),
                dataSet: vm.categories,
                isLoading: vm.isBusy,
                itemBuilder: (context, index) {
                  return CategoryListItem(
                    category: vm.categories[index],
                    onPressed: vm.categorySelected,
                    maxLine: false,
                  );
                },
              ).expand(),
            ],
          ),
        );
      },
    );
  }
}
