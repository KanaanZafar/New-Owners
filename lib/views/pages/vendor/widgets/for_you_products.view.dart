import 'package:flutter/material.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor/for_you_products.vm.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.sm.list_item.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/for_you_products.i18n.dart';

class ForYouProducts extends StatelessWidget {
  const ForYouProducts(this.vendorType, {Key key}) : super(key: key);
  final VendorType vendorType;
  
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForYouProductsViewModel>.reactive(
      viewModelBuilder: () => ForYouProductsViewModel(context,vendorType),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) {
        return VStack(
          [
            //
            "For You".i18n.text.make().px12().py2(),
            CustomListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 2),
              separatorBuilder: (context,index) => UiSpacer.smHorizontalSpace(),
              dataSet: model.products,
              isLoading: model.isBusy,
              itemBuilder: (context, index) {
                //
                return SmallHorizontalProductListItem(
                  model.products[index],
                  onPressed: model.productSelected,
                  qtyUpdated: model.addToCartDirectly,
                );
              },
            ).h(90),
          ],
        );
      },
    );
  }
}
