import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/services/local_storage.service.dart';
import 'package:velocity_x/velocity_x.dart';

class AppColor {
  static Color get accentColor => Vx.hexToColor(colorEnv('accentColor'));

  static Color get primaryColor => Vx.hexToColor(colorEnv('primaryColor'));

  static Color get primaryColorDark =>
      Vx.hexToColor(colorEnv('primaryColorDark'));

  static Color get cursorColor => accentColor;

  //material color
  static MaterialColor get accentMaterialColor => MaterialColor(
        Vx.getColorFromHex(colorEnv('accentColor')),
        <int, Color>{
          50: Vx.hexToColor(colorEnv('accentColor')),
          100: Vx.hexToColor(colorEnv('accentColor')),
          200: Vx.hexToColor(colorEnv('accentColor')),
          300: Vx.hexToColor(colorEnv('accentColor')),
          400: Vx.hexToColor(colorEnv('accentColor')),
          500: Vx.hexToColor(colorEnv('accentColor')),
          600: Vx.hexToColor(colorEnv('accentColor')),
          700: Vx.hexToColor(colorEnv('accentColor')),
          800: Vx.hexToColor(colorEnv('accentColor')),
          900: Vx.hexToColor(colorEnv('accentColor')),
        },
      );

  static MaterialColor get primaryMaterialColor => MaterialColor(
        Vx.getColorFromHex(colorEnv('primaryColor')),
        <int, Color>{
          50: Vx.hexToColor(colorEnv('primaryColor')),
          100: Vx.hexToColor(colorEnv('primaryColor')),
          200: Vx.hexToColor(colorEnv('primaryColor')),
          300: Vx.hexToColor(colorEnv('primaryColor')),
          400: Vx.hexToColor(colorEnv('primaryColor')),
          500: Vx.hexToColor(colorEnv('primaryColor')),
          600: Vx.hexToColor(colorEnv('primaryColor')),
          700: Vx.hexToColor(colorEnv('primaryColor')),
          800: Vx.hexToColor(colorEnv('primaryColor')),
          900: Vx.hexToColor(colorEnv('primaryColor')),
        },
      );

  static MaterialColor get primaryMaterialColorDark =>
      Vx.hexToColor(colorEnv('primaryColorDark'));

  static MaterialColor get cursorMaterialColor => accentColor;

  //onboarding colors
  static Color get onboarding1Color =>
      Vx.hexToColor(colorEnv('onboarding1Color'));

  static Color get onboarding2Color =>
      Vx.hexToColor(colorEnv('onboarding2Color'));

  static Color get onboarding3Color =>
      Vx.hexToColor(colorEnv('onboarding3Color'));

  static Color get onboardingIndicatorDotColor =>
      Vx.hexToColor(colorEnv('onboardingIndicatorDotColor'));

  static Color get onboardingIndicatorActiveDotColor =>
      Vx.hexToColor(colorEnv('onboardingIndicatorActiveDotColor'));

  //Shimmer Colors
  static Color shimmerBaseColor = Colors.grey[300];
  static Color shimmerHighlightColor = Colors.grey[200];

  //inputs
  static Color get inputFillColor => Colors.grey[200];

  static Color get iconHintColor => Colors.grey[500];

  static Color get openColor => Vx.hexToColor(colorEnv('openColor'));

  static Color get closeColor => Vx.hexToColor(colorEnv('closeColor'));

  static Color get deliveryColor => Vx.hexToColor(colorEnv('deliveryColor'));

  static Color get pickupColor => Vx.hexToColor(colorEnv('pickupColor'));

  static Color get ratingColor => Vx.hexToColor(colorEnv('ratingColor'));

  static Color getStausColor(String status) {
    //'pending','preparing','enroute','failed','cancelled','delivered'
    switch (status) {
      case "pending":
        return Vx.hexToColor(colorEnv('pendingColor'));
        break;
      case "preparing":
        return Vx.hexToColor(colorEnv('preparingColor'));
        break;
      case "enroute":
        return Vx.hexToColor(colorEnv('enrouteColor'));
        break;
      case "failed":
        return Vx.hexToColor(colorEnv('failedColor'));
        break;
      case "cancelled":
        return Vx.hexToColor(colorEnv('cancelledColor'));
        break;
      case "delivered":
        return Vx.hexToColor(colorEnv('deliveredColor'));
      case "successful":
        return Vx.hexToColor(colorEnv('successfulColor'));
        break;
      default:
        return Vx.hexToColor(colorEnv('pendingColor'));
    }
  }

  //saving
  static Future<bool> saveColorsToLocalStorage(String colorsMap) async {
    return await LocalStorageService.prefs
        .setString(AppStrings.appColors, colorsMap);
  }

  static dynamic appColorsObject;

  static Future<void> getColorsFromLocalStorage() async {
    appColorsObject = LocalStorageService.prefs.getString(AppStrings.appColors);
    if (appColorsObject != null) {
      appColorsObject = jsonDecode(appColorsObject);
    }
  }

  static String colorEnv(String colorRef) {
    //
    getColorsFromLocalStorage();
    //
    final selectedColor =
        appColorsObject != null ? appColorsObject[colorRef] : "#000000";
    return selectedColor;
  }
}

extension NaguaraColors on AppColor {
//naguaraColors
  static Color naGuaraBGColor = Color(0xffF5F5F5);
  static Color naGuaraPrimaryColor = Color(0xffFF9C00);
  static Color fieldBorderColor = Color(0xffCBCBCB);

  static Color shadowColor = Color(0x0000001A);
  static Color placeHolderColor = Color(0xff959595);

  /*static Map<int, Color> primaryColorSwatch = const {
    50: Color.fromRGBO(227, 10, 32, .1),
    100: Color.fromRGBO(227, 10, 32, .2),
    200: Color.fromRGBO(227, 10, 32, .3),
    300: Color.fromRGBO(227, 10, 32, .4),
    400: Color.fromRGBO(227, 10, 32, .5),
    500: Color.fromRGBO(227, 10, 32, .6),
    600: Color.fromRGBO(227, 10, 32, .7),
    700: Color.fromRGBO(227, 10, 32, .8),
    800: Color.fromRGBO(227, 10, 32, .9),
    900: Color.fromRGBO(227, 10, 32, 1),
  }; */
  static Map<int, Color> primarySwatchForNaguara = const {
    //rgb(255, 156, 0)
    50: Color.fromRGBO(255, 156, 0, .1),
    100: Color.fromRGBO(255, 156, 0, .2),
    200: Color.fromRGBO(255, 156, 0, .3),
    300: Color.fromRGBO(255, 156, 0, .4),
    400: Color.fromRGBO(255, 156, 0, .5),
    500: Color.fromRGBO(255, 156, 0, .6),
    600: Color.fromRGBO(255, 156, 0, .7),
    700: Color.fromRGBO(255, 156, 0, .8),
    800: Color.fromRGBO(255, 156, 0, .9),
    900: Color.fromRGBO(255, 156, 0, 1),
  };

  // MaterialColor primaryColor =
  // MaterialColor(0xffE30A20, AbsoluteReloColors.primaryColorSwatch);
  static MaterialColor primaryMaterialColorForNaguara =
      MaterialColor(0xffFF9C00, primarySwatchForNaguara);
}
