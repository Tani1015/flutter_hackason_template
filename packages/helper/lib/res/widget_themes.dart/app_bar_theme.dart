import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper/res/app_colors.dart';
import 'package:helper/res/typography.dart';

TextStyle get _baseTextStyle {
  return baseTextTheme.bodyLarge!.copyWith(
    fontWeight: FontWeight.bold,
  );
}

AppBarTheme get appBarThemeLight {
  return AppBarTheme(
    foregroundColor: AppColors.backgroundColor,
    surfaceTintColor: AppColors.backgroundColor,
    titleTextStyle: _baseTextStyle,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.textColor,
      systemNavigationBarColor: AppColors.primaryColor,
      systemNavigationBarDividerColor: AppColors.outline,
    ),
  );
}

AppBarTheme get appBarThemeDark {
  return AppBarTheme(
    foregroundColor: AppColors.backgroundColor,
    surfaceTintColor: AppColors.backgroundColor,
    titleTextStyle: _baseTextStyle,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: AppColors.backgroundColor,
      systemNavigationBarColor: AppColors.textColor,
      systemNavigationBarDividerColor: AppColors.outline,
    ),
  );
}
