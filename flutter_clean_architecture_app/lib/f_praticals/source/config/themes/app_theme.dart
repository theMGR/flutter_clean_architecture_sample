import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flearn/f_praticals/source/constants/color_constants.dart';

import 'text_theme.dart';

class AppTheme {
  static ThemeData theme() => ThemeData.light().copyWith(
        primaryColor: ColorConstant.primaryColor,
        // textTheme: const TextTheme().apply(
        //   bodyColor: Colors.white,
        //   displayColor: Colors.white,
        // ),
        primaryColorDark: Colors.white,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        cardTheme: CardTheme(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: ColorConstant.bg, width: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 3,
        ),
        appBarTheme: AppBarTheme(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: Colors.white,
            foregroundColor: ColorConstant.blackColor,
            titleTextStyle: CustomStyles.fixAppBarTextStyle.copyWith(fontWeight: FontWeight.bold),
            elevation: 0,
            centerTitle: true,
            titleSpacing: 5),
        checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return ColorConstant.royalBlue;
          }
          return Colors.white;
        })),
        radioTheme: RadioThemeData(fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return ColorConstant.primaryColor;
          }
          return Colors.grey;
        })),
        colorScheme: const ColorScheme.light()
            .copyWith(
              brightness: Brightness.light,
              secondary: ColorConstant.primaryColorAccent,
              primary: ColorConstant.primaryColor,
            )
            .copyWith(background: Colors.white),
      );
}
