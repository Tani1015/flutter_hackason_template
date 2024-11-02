import 'package:flutter/material.dart';
import '../../../../game_constants.dart';

enum OrbType {
  fire;

  bool get isFire => this == OrbType.fire;

  List<Color> get colors => GameConstants.redColors;

  Color get baseColor => colors.first;

  Color get intenseColor => colors.last;
}
