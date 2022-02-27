// import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  @override
  void onOpened() {
    print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    print("ChromeSafari browser closed");
  }
}

class PaymentViewModel extends MyBaseViewModel {
  refreshDataSet() {}
  //
  openWebpageLink(String url) async {
    //
    try {
      ChromeSafariBrowser browser = new MyChromeSafariBrowser();
      await browser.open(
        url: Uri.parse(url),
        options: ChromeSafariBrowserClassOptions(
          android: AndroidChromeCustomTabsOptions(
            addDefaultShareMenuItem: false,
            enableUrlBarHiding: true,
          ),
          ios: IOSSafariOptions(
            barCollapsingEnabled: true,
          ),
        ),
      );
    } catch (error) {
      await launch(url);
    }
    //
    refreshDataSet();
  }
}
