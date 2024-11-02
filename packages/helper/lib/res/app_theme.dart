import 'package:flutter/material.dart';
import 'package:helper/res/app_color_scheme.dart';
import 'package:helper/res/app_colors.dart';
import 'package:helper/res/typography.dart';
import 'package:helper/res/widget_themes/app_bar_theme.dart';
import 'package:helper/res/widget_themes/elevated_button_theme.dart';
import 'package:helper/res/widget_themes/filled_button_theme.dart';
import 'package:helper/res/widget_themes/floating_action_button_theme.dart';
import 'package:helper/res/widget_themes/input_decoration_theme.dart';
import 'package:helper/res/widget_themes/list_tile_theme.dart';
import 'package:helper/res/widget_themes/outlined_button_theme.dart';

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
