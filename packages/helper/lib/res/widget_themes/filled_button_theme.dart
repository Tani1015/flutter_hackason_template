import 'package:flutter/material.dart';
import 'package:helper/res/constants.dart';
import 'package:helper/res/typography.dart';

final appFilledButtonTheme = FilledButtonThemeData(
  style: FilledButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        kBorderRadius,
      ),
    ),
    textStyle: baseTextTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.bold,
    ),
  ),
);