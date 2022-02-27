import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/view_models/vendor_details.vm.dart';
import 'package:fuodz/views/pages/vendor_details/vendor_category_products.page.dart';
import 'package:fuodz/views/pages/vendor_details/widgets/vendor_details_header.view.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_masonry_grid_view.dart';
import 'package:fuodz/widgets/list_items/category.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorDetailsWithSubcategoryPage extends StatelessWidget {
  VendorDetailsWithSubcategoryPage({this.vendor, Key key}) : super(key: key);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () => VendorDetailsViewModel(context, vendor),
      onModelReady: (model) => model.getVendorDetails(),
      builder: (context, model, child) {
        return VStack(
          [
            //
            VendorDetailsHeader(model),
            //categories
            model.isBusy
                ? BusyIndicator().p20().centered()
                :

            CustomMasonryGridView(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              items: model.vendor.categories
                  .map(
                    (category) => CategoryListItem(
                      category: category,
                      onPressed: (category) {
                        //
                        context.nextPage(
                          VendorCategoryProductsPage(
                            category: category,
                            vendor: model.vendor,
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ).p20(),
          ],
        ).scrollVertical();
      },
    );
  }
}
