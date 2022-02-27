import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/category.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem(
      {this.category, this.onPressed, this.maxLine = true, Key key})
      : super(key: key);

  final Function(Category) onPressed;
  final Category category;
  final bool maxLine;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        //
        CustomImage(
          imageUrl: category.imageUrl,
          boxFit: BoxFit.fill,
          width: AppStrings.categoryImageWidth,
          height: AppStrings.categoryImageHeight,
        )
            .p12()
            .box
            .roundedSM
            .clip(Clip.antiAlias)
            .color(Vx.hexToColor(category.color))
            .make()
            .py2(),

        //
        category.name.text
            .minFontSize(AppStrings.categoryTextSize)
            .size(AppStrings.categoryTextSize)
            .center
            .maxLines(1)
            .overflow(TextOverflow.ellipsis)
            .make()
            .p2()
            .expand(),
      ],
      crossAlignment: CrossAxisAlignment.center,
      alignment: MainAxisAlignment.start,
    )
        .w((AppStrings.categoryImageWidth * 1.8) + AppStrings.categoryTextSize)
        .h((AppStrings.categoryImageHeight * 1.8) +AppStrings.categoryImageHeight)
        .onInkTap(
          () => this.onPressed(this.category),
        )
        .px4();
  }
}
