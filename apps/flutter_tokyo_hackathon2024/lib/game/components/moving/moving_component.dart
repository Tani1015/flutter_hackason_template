import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/orb/moving_orb_head.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/orb/moving_orb_tail_particles.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/orb/orb_disjoint_particle.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/orb/orb_type.dart';
import '../../../riverpod/game_state/game_state.dart';
import '../../../riverpod/game_state/game_state_notifier.dart';
import '../../neko_game.dart';

part 'orb/moving_orb.dart';

sealed class MovingComponent extends PositionComponent
    with HasGameRef<NekoGame>, HasTimeScale, RiverpodComponentMixin {
  MovingComponent({
    required this.speed,
    required double size,
    required this.target,
    required super.position,
  }) : super(size: Vector2.all(size), priority: 1);

  final double speed;
  final PositionComponent target;

  Random get rnd => game.rnd;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    ref.listen<GameState>(gameStateProvider, (previous, next) {
      timeScale = next.gameOverTimeScale;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);

    final gameState = ref.read(gameStateProvider);

    if (gameState.playingState.isGameOver) {
      removeFromParent();
    }

    final angle = atan2(
      target.position.y - position.y,
      target.position.x - position.x,
    );
    position += Vector2(cos(angle), sin(angle)) * speed * dt;
  }
}
