import 'package:flutter/material.dart';
import 'package:helper/res/app_color_scheme.dart';
import 'package:helper/res/app_colors.dart';
import 'package:helper/res/typography.dart';
import 'package:helper/res/widget_themes.dart/app_bar_theme.dart';
import 'package:helper/res/widget_themes.dart/elevated_button_theme.dart';
import 'package:helper/res/widget_themes.dart/filled_button_theme.dart';
import 'package:helper/res/widget_themes.dart/floating_action_button_theme.dart';
import 'package:helper/res/widget_themes.dart/input_decoration_theme.dart';
import 'package:helper/res/widget_themes.dart/list_tile_theme.dart';
import 'package:helper/res/widget_themes.dart/outlined_button_theme.dart';

ThemeData _baseThemeData(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
    elevatedButtonTheme: appElevatedButtonTheme,
    filledButtonTheme: appFilledButtonTheme,
    floatingActionButtonTheme: appFloatingActionButtonTheme,
    inputDecorationTheme: appInputDecorationTheme,
    listTileTheme: appListTileTheme,
    outlinedButtonTheme: appOutLinedButtonTheme,
    splashFactory: InkRipple.splashFactory,
  );
}

ThemeData get themeLight {
  return _baseThemeData(
    colorSchemeLight,
  ).copyWith(
    appBarTheme: appBarThemeLight,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: textThemeLight,
  );
}

ThemeData get themeDark {
  return _baseThemeData(
    colorSchemeDark,
  ).copyWith(
    appBarTheme: appBarThemeDark,
    scaffoldBackgroundColor: AppColors.onBackgroundColor,
    textTheme: textThemeDark,
  );
}
