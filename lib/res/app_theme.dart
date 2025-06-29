import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.lightPrimary,
    dividerColor: AppColors.lightDivider,
    canvasColor: AppColors.lightCanvas,
    dialogBackgroundColor: AppColors.lightBackground,
    shadowColor: AppColors.lightShadowColor,
    hoverColor: AppColors.lightSecondaryAccent.withOpacity(0.5),
    focusColor: AppColors.lightSecondaryAccent.withOpacity(0.5),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.light(
      background: AppColors.lightBackground, // <- use this instead
      secondary: AppColors.lightSecondaryAccent,
      primary: AppColors.lightPrimaryAccent,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      titleTextStyle: ThemeData.light()
          .textTheme
          .titleLarge!
          .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
      iconTheme: ThemeData.light().iconTheme,
      color: AppColors.lightPrimary,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.lightSecondaryAccent,
    ),
  );
}
