import 'package:flutter/material.dart';
import 'package:fuodz/view_models/grocery.vm.dart';
import 'package:fuodz/widgets/custom_masonry_grid_view.dart';
import 'package:fuodz/widgets/list_items/grid_view_product.list_item.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor/vendor_type_view.i18n.dart';

class GroceryPicksView extends StatelessWidget {
  const GroceryPicksView(this.vm, {Key key}) : super(key: key);

  final GroceryViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        "Pick's Today".i18n.text.make().p12(),
        CustomMasonryGridView(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          items: vm.productPicks
              .map(
                (product) => GridViewProductListItem(
                  product: product,
                  onPressed: vm.productSelected,
                  qtyUpdated: vm.addToCartDirectly,
                  showStepper: true,
                ),
              )
              .toList(),
        ).px12(),
      ],
    ).py12();
  }
}
