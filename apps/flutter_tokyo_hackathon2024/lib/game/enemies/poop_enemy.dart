import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import '../neko_game.dart';

class PoopEnemy extends SpriteComponent with HasGameRef<NekoGame> {
  final double speed;
  final Random random = Random();

  PoopEnemy({required this.speed, Vector2? position, Vector2? size})
      : super(
          size: size ?? Vector2(25, 15),
          position: position,
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemies/poop.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Mueve el enemigo hacia abajo
    y += speed * dt;

    // Elimina el enemigo cuando sale de la pantalla
    if (y > gameRef.size.y) {
      removeFromParent();
    }
  }
}