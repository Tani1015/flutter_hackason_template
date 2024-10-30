import 'package:flutter/material.dart';
import 'package:helper/res/constants.dart';
import 'package:helper/res/typography.dart';

final appListTileTheme = ListTileThemeData(
  titleTextStyle: baseTextTheme.bodyMedium!.copyWith(
    fontWeight: FontWeight.bold,
  ),
  minVerticalPadding: 8,
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
  ),
);
