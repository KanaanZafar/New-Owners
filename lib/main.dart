import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/my_app.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/cart.service.dart';
import 'package:fuodz/services/general_app.service.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:fuodz/services/firebase.service.dart';
import 'package:fuodz/services/notification.service.dart';
import 'package:i18n_extension/i18n_widget.dart';

//ssll handshake error
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //
  await LocalStorageService.getPrefs();
  await CartServices.getCartItems();
  //setting up firebase notifications
  await Firebase.initializeApp();
  await NotificationService.clearIrrelevantNotificationChannels();
  await NotificationService.initializeAwesomeNotification();
  await NotificationService.listenToActions();
  await FirebaseService().setUpFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(GeneralAppService.onBackgroundMessageHandler);

  //prevent ssl error
  HttpOverrides.global = new MyHttpOverrides();
  // Run app!
  runApp(
    I18n(
      initialLocale: Locale(AuthServices.getLocale()),
      child: MyApp(),
    ),
  );
}
