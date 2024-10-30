import 'package:flutter/material.dart';
import 'package:helper/res/app_colors.dart';

ColorScheme get colorSchemeLight {
  return ColorScheme.fromSeed(
    seedColor: AppColors.seedColor,
    primary: AppColors.primaryColor,
    onPrimary: AppColors.backgroundColor,
    primaryContainer: AppColors.primaryContainerColor,
    onPrimaryContainer: AppColors.onPrimaryContainerColor,
    secondary: AppColors.secondaryColor,
    onSecondary: AppColors.backgroundColor,
    secondaryContainer: AppColors.secondaryContainerColor,
    onSecondaryContainer: AppColors.onSecondaryContainerColor,
    tertiary: AppColors.tertiaryColor,
    onTertiary: AppColors.backgroundColor,
    tertiaryContainer: AppColors.tertiaryContainerColor,
    onTertiaryContainer: AppColors.onTertiaryContainerColor,
    error: AppColors.errorColor,
    onError: AppColors.backgroundColor,
    errorContainer: AppColors.errorContainerColor,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.backgroundColor,
    onSurface: AppColors.onSurface,
    inversePrimary: AppColors.inversePrimary,
    inverseSurface: AppColors.inverseSurfaceColor,
    onInverseSurface: AppColors.inverseOnSurfaceColor,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    shadow: AppColors.shadow,
  );
}

//TODO: light と同じなので再定義
ColorScheme get colorSchemeDark {
  return ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.seedColor,
    primary: AppColors.primaryColor,
    onPrimary: AppColors.backgroundColor,
    primaryContainer: AppColors.primaryContainerColor,
    onPrimaryContainer: AppColors.onPrimaryContainerColor,
    secondary: AppColors.secondaryColor,
    onSecondary: AppColors.backgroundColor,
    secondaryContainer: AppColors.secondaryContainerColor,
    onSecondaryContainer: AppColors.onSecondaryContainerColor,
    tertiary: AppColors.tertiaryColor,
    onTertiary: AppColors.backgroundColor,
    tertiaryContainer: AppColors.tertiaryContainerColor,
    onTertiaryContainer: AppColors.onTertiaryContainerColor,
    error: AppColors.errorColor,
    onError: AppColors.backgroundColor,
    errorContainer: AppColors.errorContainerColor,
    onErrorContainer: AppColors.onErrorContainer,
    surface: AppColors.backgroundColor,
    onSurface: AppColors.onSurface,
    inversePrimary: AppColors.inversePrimary,
    inverseSurface: AppColors.inverseSurfaceColor,
    onInverseSurface: AppColors.inverseOnSurfaceColor,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    shadow: AppColors.shadow,
  );
}
