import 'package:flutter/material.dart';
// import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/vendor/categories.vm.dart';
// import 'package:fuodz/views/pages/category/categories.page.dart';
// import 'package:fuodz/widgets/custom_grid_view.dart';
// import 'package:fuodz/widgets/list_items/category.list_item.dart';
import 'package:fuodz/widgets/vendor_type_categories.view.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/vendor_type_view.i18n.dart';

class GroceryCategories extends StatefulWidget {
  const GroceryCategories(this.vendorType, {Key key}) : super(key: key);

  final VendorType vendorType;
  @override
  _GroceryCategoriesState createState() => _GroceryCategoriesState();
}

class _GroceryCategoriesState extends State<GroceryCategories> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () =>
          CategoriesViewModel(context, vendorType: widget.vendorType),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return VStack(
          [
            //
             VendorTypeCategories(
              widget.vendorType,
              showTitle: true,
              title: "What are you getting today?".i18n,
              childAspectRatio: 1.4,
              crossAxisCount: AppStrings.categoryPerRow,
              lessItemCount: 6,
            ),
            //
            // HStack(
            //   [
            //     "What are you getting today?".i18n.text.medium.make().expand(),
            //     //
            //     (!isOpen ? "See all" : "Show less")
            //         .i18n
            //         .text
            //         .sm
            //         .color(AppColor.primaryColor)
            //         .make()
            //         .onInkTap(() {
            //       context.nextPage(
            //         CategoriesPage(vendorType: widget.vendorType),
            //       );
            //     }),
            //   ],
            // ).p12(),

            //categories list
            // CustomGridView(
            //   // scrollDirection: Axis.horizontal,
            //   noScrollPhysics: true,
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   dataSet: model.categories,
            //   isLoading: model.isBusy,
            //   crossAxisCount: AppStrings.categoryPerRow,
            //   childAspectRatio: 1.0,
            //   mainAxisSpacing: 10,
            //   crossAxisSpacing: 10,
            //   itemBuilder: (context, index) {
            //     //
            //     return CategoryListItem(
            //       category: model.categories[index],
            //       onPressed: model.categorySelected,
            //     );
            //   },
            // ),
          ],
        );
      },
    );
  }
}
