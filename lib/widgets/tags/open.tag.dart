import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/translations/vendor/top_vendor.i18n.dart';
import 'package:velocity_x/velocity_x.dart';

class OpenTag extends StatelessWidget {
  const OpenTag({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return "Open"
        .i18n
        .text.sm
        .white
        .make()
        .py2()
        .px8()
        .box
        .roundedLg
        .color(AppColor.openColor)
        .make();
  }
}
