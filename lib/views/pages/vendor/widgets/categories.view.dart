import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/view_models/vendor/categories.vm.dart';
import 'package:fuodz/widgets/custom_horizontal_list_view.dart';
import 'package:fuodz/widgets/list_items/category.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/categories.i18n.dart';

class Categories extends StatelessWidget {
  const Categories(this.vendorType, {Key key}) : super(key: key);
  final VendorType vendorType;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: () => CategoriesViewModel(
        context,
        vendorType: vendorType,
      ),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return VStack(
          [
            //
            "Categories".i18n.text.medium.make().p12(),

            //categories list
            CustomHorizontalListView(
              itemsViews: model.categories.map(
                (category) {
                  return CategoryListItem(
                    category: category,
                    onPressed: model.categorySelected,
                  );
                },
              ).toList(),
            ),
          ],
        );
      },
    );
  }
}
