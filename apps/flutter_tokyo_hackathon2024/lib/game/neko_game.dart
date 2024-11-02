import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_tokyo_hackathon2024/game/player/neko.dart';

class NekoGame extends FlameGame<MyWorld>
    with HasCollisionDetection, RiverpodGameMixin<MyWorld> {
  NekoGame()
      : super(
            world: MyWorld(),
            camera:
                CameraComponent.withFixedResolution(width: 600, height: 600));

  @override
  Future<void> onLoad() async {
    await Flame.images.loadAll([
      ...List.generate(8, (index) => 'flame/flame${index + 1}.png'),
      ...List.generate(2, (index) => 'snow/snowflake${index + 1}.png'),
      ...List.generate(2, (index) => 'sparkle/sparkle${index + 1}.png'),
      'two-way-arrow.png',
    ]);
    // remove(world);
  }

  

  Random rnd = Random();
}

class MyWorld extends World with HasGameRef<NekoGame> {
  late Neko player;

  @override
  FutureOr<void> onLoad() async {
    await add(player = Neko());
    return super.onLoad();
  }
}
