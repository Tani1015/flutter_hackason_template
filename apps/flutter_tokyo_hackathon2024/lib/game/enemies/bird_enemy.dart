import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import '../neko_game.dart';
import 'poop_enemy.dart'; // Importa la clase PoopEnemy

class BirdEnemy extends SpriteComponent with HasGameRef<NekoGame>{
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
    anchor = Anchor.center; 

    final randomDropTime = 1 + random.nextDouble() * 10; 
    dropTimer = Timer(
      randomDropTime,
      onTick: _dropPoop,
      repeat: false,
    );
    dropTimer.start();

    final nekoPosition = gameRef.world.player.position;
    final birdY = nekoPosition.y - 200;

     position = Vector2(gameRef.size.x + size.x, birdY);
  }

 void _dropPoop() {
   
    final poopPosition = position + Vector2(0, size.y / 2);

    final nekoPosition = gameRef.world.player.position;
    final poop = PoopEnemy(
      speed: 150,
      position: poopPosition,
      targetPosition: nekoPosition, 
    );
    gameRef.world.add(poop);
  }


  @override
  void update(double dt) {
    super.update(dt);

    x -= speed * dt;
  final nekoPosition = gameRef.world.player.position;
    if (x < nekoPosition.x - 200) {
      final nekoPosition = gameRef.world.player.position;
      final birdY = nekoPosition.y - 200; 
      y = birdY;
      x = gameRef.size.x + size.x;
      dropTimer.start();
    }

    dropTimer.update(dt);
  }
}