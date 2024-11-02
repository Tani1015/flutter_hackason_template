import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/generated/assets.gen.dart';
import 'package:helper/presentation/widgets/lottie.dart';
import '../../riverpod/game_state/game_state_notifier.dart';
import '../../riverpod/playing_state.dart';
import '../../riverpod/playing_state_notifier.dart';
import '../components/orb_type.dart';
import '../components/shield.dart';
import '../neko_game.dart';

class Neko extends PositionComponent
    with
        HasGameRef<NekoGame>,
        CollisionCallbacks,
        ParentIsA<MyWorld>,
        RiverpodComponentMixin {
  Neko({
    double size = 100,
  }) : super(
          size: Vector2.all(size),
          position: Vector2.all(0),
          anchor: Anchor.center,
        );

  late final Shield shield;

  double rotationSpeed = 0;

  double get radius => size.x / 2;

  late AnimationController lottieController;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      CircleHitbox(
        radius: radius * 0.7,
        position: size / 2,
        anchor: Anchor.center,
      ),
    );

    game.overlays.add(
      'LottieOverlay',
    );

    add(shield = Shield(type: OrbType.fire));
  }

  @override
  void update(double dt) {
    super.update(dt);
    final playState = ref.watch(playingStateProvider);
    final gameState = ref.watch(gameStateProvider);

    if (playState.isNone) {
      final rotationSpeed = gameState.shieldsAngleRotationSpeed;

      if (rotationSpeed != 0) {
        shield.angle += rotationSpeed * dt;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    other.removeFromParent();
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onRemove() {
    // リソースを解放
    lottieController.dispose();
    super.onRemove();
  }
}
