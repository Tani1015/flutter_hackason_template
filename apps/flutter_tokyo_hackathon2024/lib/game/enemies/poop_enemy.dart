import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import '../neko_game.dart';

class PoopEnemy extends SpriteComponent with HasGameRef<NekoGame> {
  final double speed;

  PoopEnemy({required this.speed, Vector2? position, Vector2? size})
      : super(position: position, size: size ?? Vector2(20, 20));

  @override
  Future<void> onLoad() async {
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
}