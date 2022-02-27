import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor/categories.vm.dart';
import 'package:fuodz/views/pages/category/categories.page.dart';
import 'package:fuodz/widgets/list_items/category.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/vendor_type_view.i18n.dart';

import 'custom_masonry_grid_view.dart';

class VendorTypeCategories extends StatefulWidget {
  const VendorTypeCategories(
    this.vendorType, {
    this.title,
    this.description,
    this.showTitle = true,
    this.crossAxisCount,
    this.childAspectRatio,
    this.lessItemCount = 6,
    Key key,
  }) : super(key: key);

  //
  final VendorType vendorType;
  final String title;
  final String description;
  final bool showTitle;
  final int crossAxisCount;
  final double childAspectRatio;
  final int lessItemCount;
  @override
  _VendorTypeCategoriesState createState() => _VendorTypeCategoriesState();
}

class _VendorTypeCategoriesState extends State<VendorTypeCategories> {
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
            HStack(
              [
                VStack(
                  [
                    widget.showTitle
                        ? ((widget.title != null
                                ? widget.title
                                : "We are here for you")
                            .i18n
                            .text
                            .lg
                            .medium
                            .make())
                        : UiSpacer.emptySpace(),
                    (widget.description != null
                            ? widget.description
                            : "How can we help?")
                        .i18n
                        .text
                        .xl
                        .semiBold
                        .make(),
                  ],
                ).expand(),
                //
                (!isOpen ? "See all" : "Show less")
                    .i18n
                    .text
                    .color(AppColor.primaryColor)
                    .make()
                    .onInkTap(
                  () {
                    context.nextPage(
                      CategoriesPage(vendorType: widget.vendorType),
                    );
                  },
                ),
              ],
            ).p12(),

            //categories list
            CustomMasonryGridView(
              crossAxisCount: AppStrings.categoryPerRow,
              // childAspectRatio: widget.childAspectRatio ?? 1.1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              items:
                  ((!isOpen && model.categories.length > widget.lessItemCount)
                          ? model.categories.sublist(0, widget.lessItemCount)
                          : model.categories)
                      .map((category) {
                return CategoryListItem(
                  category: category,
                  onPressed: model.categorySelected,
                );
              }).toList(),
            ),
            // CustomGridView(
            //   // scrollDirection: Axis.horizontal,
            //   noScrollPhysics: true,
            //   padding: EdgeInsets.symmetric(horizontal: 10),
            //   dataSet:
            //       (!isOpen && model.categories.length > widget.lessItemCount)
            //           ? model.categories.sublist(0, widget.lessItemCount)
            //           : model.categories,
            //   isLoading: model.isBusy,
            //   crossAxisCount: widget.crossAxisCount ?? 3,
            //   childAspectRatio: widget.childAspectRatio ?? 1.1,
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
