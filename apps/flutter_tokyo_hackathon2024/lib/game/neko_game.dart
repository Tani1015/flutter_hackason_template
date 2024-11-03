import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tokyo_hackathon2024/game/enemies/poop_enemy.dart';
import 'package:flutter_tokyo_hackathon2024/game/player/neko.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_state_notifier.dart';

import 'enemies/bird_enemy.dart';
import 'enemies/rock.dart';

class NekoGame extends FlameGame<MyWorld>
    with HasCollisionDetection, RiverpodGameMixin<MyWorld>, KeyboardEvents {
  NekoGame()
      : super(
          world: MyWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 600,
          ),
        );

  late Timer enemySpawnTimer;

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAll([
      ...List.generate(8, (index) => 'flame/flame${index + 1}.png'),
      ...List.generate(2, (index) => 'snow/snowflake${index + 1}.png'),
      ...List.generate(2, (index) => 'sparkle/sparkle${index + 1}.png'),
      'two-way-arrow.png',
    ]);

    super.onLoad();
  }


  @override
  void update(double dt) {
    ref.read(gameStateProvider.notifier).update(dt);
    super.update(dt);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    return ref.read(gameStateProvider.notifier).handleKeyEvent(
          event,
          keysPressed,
        );
  }

  Random rnd = Random();
}

class MyWorld extends World with HasGameRef<NekoGame>, HasCollisionDetection {
  late Neko player;
  late Timer enemySpawnTimer;
   late Timer rockSpawnTimer;

  @override
  FutureOr<void> onLoad() async {
    await add(player = Neko());
    enemySpawnTimer = Timer(4, repeat: true, onTick: _spawnEnemy);
    enemySpawnTimer.start();

    rockSpawnTimer = Timer(5, repeat: true, onTick: _spawnRock); 
    rockSpawnTimer.start();
    return super.onLoad();
  }

  void _spawnEnemy() {
    final bird = BirdEnemy(speed: 100);
    add(bird);
  }
  
    void _spawnRock() {

      final double screenWidth = gameRef.size.x;
    final double screenHeight = gameRef.size.y;

    // Lista de las cuatro esquinas de la pantalla
    final List<Vector2> possiblePositions = [
      Vector2(0, 0), // Esquina superior izquierda
      Vector2(screenWidth, 0), // Esquina superior derecha
      Vector2(0, screenHeight), // Esquina inferior izquierda
      Vector2(screenWidth, screenHeight), // Esquina inferior derecha
    ];

    // Seleccionar una esquina aleatoria
    final int cornerIndex = Random().nextInt(4);
    final Vector2 rockPosition = possiblePositions[cornerIndex];

    // Obtener la posición actual del gato
    final Vector2 nekoPosition = player.position;

    // Calcular la dirección hacia el gato y normalizarla
    final Vector2 direction = (nekoPosition - rockPosition).normalized();

    // Asignar una velocidad para la roca
    final double rockSpeed = 150.0;
    final Vector2 velocity = direction * rockSpeed;

    // Crear la roca y agregarla al mundo
    final rock = RockEnemy(
      position: rockPosition,
      velocity: velocity,
    );
    add(rock);
  }

  @override
  void update(double dt) {
     enemySpawnTimer.update(dt); 
      rockSpawnTimer.update(dt); 
    super.update(dt);
  }

}
