import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/vendor_type.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor_type.vertical_list_item.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/welcome.i18n.dart';

class EmptyWelcome extends StatelessWidget {
  const EmptyWelcome({this.vm, Key key}) : super(key: key);

  final WelcomeViewModel vm;
  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        VxBox(
          child: SafeArea(
            child: VStack(
              [
                ("Welcome".i18n +
                        (vm.isAuthenticated()
                            ? " ${AuthServices.currentUser?.name ?? ''}"
                            : ""))
                    .text
                    .white
                    .xl3
                    .semiBold
                    .make(),
                "How can I help you today?".i18n.text.white.xl.medium.make(),
              ],
            ).py12(),
          ),
        ).color(AppColor.primaryColor).p20.make().wFull(context),
        //
        VStack(
          [
            HStack(
              [
                "I want to:".i18n.text.xl.medium.make().expand(),
                Icon(
                  vm.showGrid ? FlutterIcons.grid_fea : FlutterIcons.list_fea,
                ).p2().onInkTap(() {
                  vm.showGrid = !vm.showGrid;
                  vm.notifyListeners();
                }),
              ],
              crossAlignment: CrossAxisAlignment.center,
            ).py4(),
            //list view
            !vm.showGrid
                ? CustomListView(
                    noScrollPhysics: true,
                    dataSet: vm.vendorTypes,
                    isLoading: vm.isBusy,
                    itemBuilder: (context, index) {
                      final vendorType = vm.vendorTypes[index];
                      return VendorTypeListItem(
                        vendorType,
                        onPressed: () {
                          vm.pageSelected(vendorType);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => UiSpacer.emptySpace(),
                  )
                : (vm.isBusy
                        ? BusyIndicator().centered()
                        : AnimationLimiter(
                            child: MasonryGrid(
                              column: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                vm.vendorTypes.length ?? 0,
                                (index) {
                                  final vendorType = vm.vendorTypes[index];
                                  return VendorTypeVerticalListItem(
                                    vendorType,
                                    onPressed: () {
                                      vm.pageSelected(vendorType);
                                    },
                                  );
                                },
                              ),
                            ),
                          ))
                    .py4(),
          ],
        ).p20(),
      ],
    ).scrollVertical();
  }
}
