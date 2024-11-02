import 'dart:async';
import 'dart:math';

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

         final Random random = Random();
  late Timer enemySpawnTimer;

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAll([
      ...List.generate(8, (index) => 'flame/flame${index + 1}.png'),
      ...List.generate(2, (index) => 'snow/snowflake${index + 1}.png'),
      ...List.generate(2, (index) => 'sparkle/sparkle${index + 1}.png'),
      'two-way-arrow.png',
    ]);

     enemySpawnTimer = Timer(2, repeat: true, onTick: _spawnEnemy);
    enemySpawnTimer.start();


    super.onLoad();
  }

    void _spawnEnemy() {
    final xPosition = random.nextDouble() * size.x;
    final enemy = PoopEnemy(
      speed: 100,
      position: Vector2(xPosition, -10), 
    );
    add(enemy);
  }

  @override
  void update(double dt) {
    ref.read(gameStateProvider.notifier).update(dt);
    enemySpawnTimer.update(dt); 
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

class MyWorld extends World with HasGameRef<NekoGame> {
  late Neko player;



  @override
  FutureOr<void> onLoad() async {
    await add(player = Neko());
    
    final enemy = PoopEnemy(speed: 20, size: Vector2(25, 15));
    add(enemy);

    return super.onLoad();
  }
}
