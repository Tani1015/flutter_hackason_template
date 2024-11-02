import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/moving_component.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/moving_component_spwaner.dart';
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

  void onOrbHit() {
    ref.read(gameStateProvider.notifier).potatoOrbHit();
  }

  Random rnd = Random();
}

class MyWorld extends World with HasGameRef<NekoGame> {
  late Neko player;

  @override
  FutureOr<void> onLoad() async {
    await add(player = Neko());
    add(
      MovingComponentSpawner(),
    );
    return super.onLoad();
  }
}
