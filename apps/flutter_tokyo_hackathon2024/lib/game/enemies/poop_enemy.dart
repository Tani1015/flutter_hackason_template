import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/shield.dart';
import 'package:flutter_tokyo_hackathon2024/game/enemies/bird_enemy.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_state_notifier.dart';

import '../neko_game.dart';

class PoopEnemy extends SpriteComponent with HasGameRef<NekoGame>, CollisionCallbacks{
  final double speed;

  PoopEnemy({required this.speed, Vector2? position, Vector2? size})
      : super(position: position, size: size ?? Vector2(20, 20));

  @override
  Future<void> onLoad() async {
    add(CircleHitbox()..debugMode = true..collisionType = CollisionType.active);
    sprite = await gameRef.loadSprite('enemies/poop.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += speed * dt; 

    if (y > gameRef.size.y) {
      removeFromParent(); 
    }
    
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Shield){
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

}