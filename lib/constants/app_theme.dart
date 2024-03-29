import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //
  ThemeData lightTheme() {
    return ThemeData(
      // fontFamily: GoogleFonts.iBMPlexSerif().fontFamily,
      fontFamily: GoogleFonts.krub().fontFamily,
      // fontFamily: GoogleFonts.hiruko,
      // fontFamily: GoogleFonts.roboto().fontFamily,
      // fontFamily: GoogleFonts.notoSans().fontFamily,
      // fontFamily: GoogleFonts.oswald().fontFamily,
      // primarySwatch: AppColor.primaryMaterialColor,
      // primaryColor: AppColor.primaryColor,
      primarySwatch: NaguaraColors.primaryMaterialColorForNaguara,
      primaryColor: NaguaraColors.naGuaraPrimaryColor,
      primaryColorDark: AppColor.primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColor.cursorColor,
      ),
      backgroundColor: NaguaraColors.naGuaraBGColor,
      unselectedWidgetColor: NaguaraColors.naGuaraPrimaryColor,
      // backgroundColor: Colors.white,

      cardColor: Colors.grey[50],
      textTheme: TextTheme(
        headline3: TextStyle(
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      // brightness: Brightness.light,
      // CUSTOMIZE showDatePicker Colors
      dialogBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(
        primary: AppColor.primaryColor,
        secondary: AppColor.accentColor,
        brightness: Brightness.light,
      ),
      buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      highlightColor: Colors.grey[400],
    );
  }

  //
  ThemeData darkTheme() {
    return ThemeData(
      // fontFamily: GoogleFonts.iBMPlexSerif().fontFamily,
      fontFamily: GoogleFonts.krub().fontFamily,
      // fontFamily: GoogleFonts.roboto().fontFamily,
      // fontFamily: GoogleFonts.notoSans().fontFamily,
      // fontFamily: GoogleFonts.oswald().fontFamily,
      // brightness: Brightness.dark,
      primarySwatch: AppColor.primaryMaterialColor,
      primaryColor: AppColor.primaryColor,
      primaryColorDark: AppColor.primaryColorDark,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.grey,
        cursorColor: AppColor.cursorColor,
      ),
      backgroundColor: Colors.grey[850],
      cardColor: Colors.grey[700],
      textTheme: TextTheme(
        headline3: TextStyle(
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.black,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColor.primaryColor,
        secondary: AppColor.accentColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
