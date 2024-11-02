import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'poop_enemy.dart'; // Importa la clase PoopEnemy

class BirdEnemy extends SpriteComponent with HasGameRef {
  final double speed;
  final Random random = Random();
  late Timer dropTimer;

  BirdEnemy({required this.speed, Vector2? size})
      : super(
          size: size ?? Vector2(50, 50), // Tamaño del pájaro
          position: Vector2.zero(),
        );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemies/bird.png'); 

    position = Vector2(gameRef.size.x + size.x, random.nextDouble() * (gameRef.size.y * 0.3));

   
    final randomDropTime = 1 + random.nextDouble() * 2; 
    dropTimer = Timer(
      randomDropTime,
      onTick: _dropPoop,
      repeat: false,
    );
    dropTimer.start();
  }

  void _dropPoop() {
  
    final poop = PoopEnemy(
      speed: 100, 
      position: Vector2(position.x, position.y + size.y),
    );
    gameRef.add(poop);
  }

  @override
  void update(double dt) {
    super.update(dt);

  
    x -= speed * dt;

  
    if (x < -size.x) {
      x = gameRef.size.x + size.x;
      y = random.nextDouble() * (gameRef.size.y * 0.3); 
      dropTimer.start();
    }

    dropTimer.update(dt);
  }
}