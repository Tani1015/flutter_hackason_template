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
    titleTextStyle: _baseTextStyle.copyWith(
      color: AppColors.textColor,
    ),
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
    titleTextStyle: _baseTextStyle.copyWith(
      color: AppColors.backgroundColor,
    ),
    backgroundColor: AppColors.onBackgroundColor,
    foregroundColor: AppColors.backgroundColor,
    surfaceTintColor: AppColors.backgroundColor,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: AppColors.textColor,
      systemNavigationBarColor: AppColors.textColor,
      systemNavigationBarDividerColor: AppColors.outline,
    ),
  );
}
