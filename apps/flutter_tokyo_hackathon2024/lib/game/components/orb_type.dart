import 'package:flutter/material.dart';
import '../../game_constants.dart';

enum OrbType {
  fire,
  ice;

  bool get isFire => this == OrbType.fire;

  bool get isIce => this == OrbType.ice;

  List<Color> get colors => switch (this) {
    OrbType.fire => GameConstants.redColors,
    OrbType.ice => GameConstants.blueColors,
  };

  Color get baseColor => colors.first;

  Color get intenseColor => colors.last;
}