import 'package:flutter/material.dart';
import 'package:helper/res/app_colors.dart';

final appOutLinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    side: const BorderSide(
      color: AppColors.outline,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
  ),
);
