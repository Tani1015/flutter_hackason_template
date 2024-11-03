import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/playing_state_notifier.dart';
import '../components/shield.dart';
import '../neko_game.dart';
import '../player/neko.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

class RockEnemy extends SpriteComponent
    with CollisionCallbacks, HasGameRef<NekoGame>, RiverpodComponentMixin {
  Vector2 velocity;

  RockEnemy({
    required Vector2 position,
    required this.velocity,
  }) : super(position: position, size: Vector2(23, 23)) {
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemies/stone.png');

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Neko) {
       ref.read(playingStateProvider.notifier).decrementScore(1);
      // ref.read(gameStateProvider.notifier).loseLife();
      removeFromParent();
    } else if (other is Shield) {
      // ref.read(gameStateProvider.notifier).winpoint();
       ref.read(playingStateProvider.notifier).incrementScore(1);
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
