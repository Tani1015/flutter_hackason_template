import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:helper/res/app_colors.dart';

final _appFonts = GoogleFonts.notoSansTextTheme();

const baseTextTheme = TextTheme(
  headlineSmall: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 34.0 / 24.0,
    letterSpacing: -0.165,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    height: 23.0 / 16.0,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    height: 26.0 / 18.0,
    letterSpacing: -0.165,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 20.0 / 14.0,
  ),
  bodySmall: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    height: 17.0 / 12.0,
    letterSpacing: -0.165,
  ),
  labelLarge: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 20.0 / 14.0,
  ),
);

TextTheme get textThemeLight {
  return _appFonts
      .apply(
        displayColor: AppColors.textColor,
        bodyColor: AppColors.textColor,
      )
      .merge(
        baseTextTheme,
      );
}

TextTheme get textThemeDark {
  return _appFonts
      .apply(
        displayColor: AppColors.backgroundColor,
        bodyColor: AppColors.backgroundColor,
      )
      .merge(
        baseTextTheme,
      );
}
