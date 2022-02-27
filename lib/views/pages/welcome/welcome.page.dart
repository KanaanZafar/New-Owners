import 'package:flutter/material.dart';
import 'package:fuodz/view_models/welcome.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/states/welcome.empty.dart';
import 'package:stacked/stacked.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({
    Key key,
  }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with AutomaticKeepAliveClientMixin<WelcomePage> {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      body: ViewModelBuilder<WelcomeViewModel>.reactive(
        viewModelBuilder: () => WelcomeViewModel(context),
        onModelReady: (vm) => vm.initialise(),
        builder: (context, vm, child) {
          return EmptyWelcome(vm: vm);
        },
      ),
    );
  }
}
