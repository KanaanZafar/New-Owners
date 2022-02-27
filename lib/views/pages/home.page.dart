import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/views/pages/profile/profile.page.dart';
import 'package:fuodz/view_models/home.vm.dart';
import 'package:fuodz/views/pages/search/search.page.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/home.i18n.dart';

import 'order/orders.page.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = HomeViewModel(context);
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        LocationService.prepareLocationListener();
        vm?.initialise();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      message: "Press back again to close".i18n,
      child: ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => vm,
        builder: (context, model, child) {
          return BasePage(
            body: PageView(
              controller: model.pageViewController,
              onPageChanged: model.onPageChanged,
              children: [
                model.homeView,
                OrdersPage(),
                SearchPage(showCancel: false),
                ProfilePage(),
              ],
            ),
            fab: SizedBox(
              height: 40,
              child: FloatingActionButton.extended(
                backgroundColor: AppColor.primaryColorDark,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: model.openCart,
                icon: Icon(
                  FlutterIcons.shopping_cart_faw,
                  color: Colors.white,
                ).badge(
                  count: model.totalCartItems,
                  color: Colors.white,
                  textStyle: context.textTheme.bodyText1?.copyWith(
                    color: AppColor.primaryColor,
                    fontSize: 10,
                  ),
                ),
                label: "Cart".i18n.text.white.make(),
              ),
            ),
            bottomNavigationBar: VxBox(
              child: SafeArea(
                child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  duration: Duration(milliseconds: 250),
                  tabBackgroundColor: Theme.of(context).colorScheme.secondary,
                  tabs: [
                    GButton(
                      icon: FlutterIcons.home_ant,
                      text: 'Home'.i18n,
                    ),
                    GButton(
                      icon: FlutterIcons.inbox_ant,
                      text: 'Orders'.i18n,
                    ),
                    GButton(
                      icon: FlutterIcons.search_fea,
                      text: 'Search'.i18n,
                    ),
                    GButton(
                      icon: FlutterIcons.menu_fea,
                      text: 'More'.i18n,
                    ),
                  ],
                  selectedIndex: model.currentIndex,
                  onTabChange: model.onTabChange,
                ),
              ),
            )
                .p16
                .shadow
                .color(Theme.of(context).bottomSheetTheme.backgroundColor)
                .make(),
          );
        },
      ),
    );
  }
}
