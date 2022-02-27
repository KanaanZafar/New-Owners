import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/models/vendor_type.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor.i18n.dart';

class ViewAllVendorsView extends StatelessWidget {
  const ViewAllVendorsView({
    Key key,
    @required this.vendorType,
  }) : super(key: key);
  final VendorType vendorType;

  @override
  Widget build(BuildContext context) {
    return AppStrings.enableSingleVendor
        ? UiSpacer.emptySpace()
        : HStack(
            [
              "View all vendors".i18n.text.white.sm.make().expand(),
              Icon(
                FlutterIcons.arrow_right_evi,
                color: Colors.white,
              )
            ],
          )
            .p8()
            .onInkTap(() {
              //open search with vendor type
              Navigator.pushNamed(
                context,
                AppRoutes.search,
                arguments: Search(
                  vendorType: vendorType,
                ),
              );
            })
            .box
            .rounded
            .color(AppColor.primaryColor)
            .make()
            .p12();
  }
}
