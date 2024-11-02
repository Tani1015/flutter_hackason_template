import 'package:flutter/material.dart';
import 'package:helper/res/app_colors.dart';
import 'package:helper/res/typography.dart';

final appInputDecorationTheme = InputDecorationTheme(
  labelStyle: baseTextTheme.bodyMedium,
  helperStyle: baseTextTheme.bodyMedium!.copyWith(
    color: AppColors.outline,
  ),
  hintStyle: baseTextTheme.bodySmall,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.errorColor,
    ),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.errorColor,
    ),
  ),
  disabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.outline,
    ),
  ),
);
