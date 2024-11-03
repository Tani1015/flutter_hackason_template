import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/shield.dart';
import 'package:flutter_tokyo_hackathon2024/game/enemies/bird_enemy.dart';
import 'package:flutter_tokyo_hackathon2024/game/player/neko.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_state_notifier.dart';

import '../neko_game.dart';

class PoopEnemy extends SpriteComponent with HasGameRef<NekoGame>, CollisionCallbacks{
  final double speed;
  final Vector2 targetPosition;
   late Vector2 velocity;

  PoopEnemy({required this.speed, Vector2? position, Vector2? size, required this.targetPosition})
      : super(position: position, size: size ?? Vector2(20, 20));

  @override
  Future<void> onLoad() async {
    add(CircleHitbox()..collisionType = CollisionType.active);
    sprite = await gameRef.loadSprite('enemies/poop.png');
    velocity = (targetPosition - position).normalized() * speed;
  }

  @override
  void update(double dt) {
    super.update(dt);
   position += velocity * dt; 

    if (y > gameRef.size.y + size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

 if (other is Neko) {
    // ref.read(gameStateProvider.notifier).loseLife();
    removeFromParent();
  } else if (other is Shield) {
    // ref.read(gameStateProvider.notifier).winpoint();
    removeFromParent();
  }
    
    super.onCollision(intersectionPoints, other);
  }

}