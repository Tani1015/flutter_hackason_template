import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/moving_component.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/multi_orb_spwner.dart';
import 'package:flutter_tokyo_hackathon2024/game/neko_game.dart';
import 'package:flutter_tokyo_hackathon2024/game/player/neko.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_mode.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_state.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_state_notifier.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/playing_state.dart';
import 'package:helper/logger/logger.dart';

import 'orb/orb_type.dart';

class MovingComponentSpawner extends Component
    with ParentIsA<MyWorld>, RiverpodComponentMixin {
  // We increase [timeSinceLastSingleOrbSpawn] to spawn the single moving orbs
  double timeSinceLastSingleOrbSpawn = 0;
  // Keeps a list of alive spawners to check if we are ready to switch to
  // the upcoming game mode. We switch only when everything is cleared
  // to prevent gameMode collision
  List<MovingOrb> aliveSingleMovingOrbs = [];

  // To reduce the delay, we want to spawn the first spawner immediately.
  // After that, we increase the [timeSinceLastMultiOrbSpawnerSpawn] to spawn
  bool multiOrbSpawnerFirstSpawned = false;
  double timeSinceLastMultiOrbSpawnerSpawn = 0;
  int multiOrbSpawnerSpawnCounter = 0;
  // Keeps a list of alive spawners to check if we are ready to switch to
  // the upcoming game mode. We switch only when everything is cleared
  // to prevent gameMode collision
  List<MultiOrbSpawner> aliveMultiOrbSpawners = [];

  final int _firstTimeHealthGeneratedCount = 0;

  double initialDelayTimeRemaining = 0;

  Neko get player => parent.player;

  NekoGame get game => parent.game;

  late GameState _previousGameState;

  GameState get gameState => ref.read(gameStateProvider);
  PlayingState get playingState => ref.read(gameStateProvider).playingState;
  GameMode get currentGameMode => ref.read(gameStateProvider).currentGameMode;
  GameMode? get upComingGameMode =>
      ref.read(gameStateProvider).upcomingGameMode;
  double get difficultly => ref.read(gameStateProvider).difficulty;
  GameState get state => ref.read(gameStateProvider);

  @override
  void onLoad() {
    super.onLoad();
    mounted.then((_) {
      _previousGameState = gameState;
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!playingState.isPlaying) {
      return;
    }
    final gameMode = currentGameMode;
    aliveSingleMovingOrbs.removeWhere((e) => e.isRemoved);
    aliveMultiOrbSpawners.removeWhere((e) => e.isRemoved);

    // Check for initial delay
    if (_previousGameState.currentGameMode.runtimeType !=
        gameMode.runtimeType) {
      initialDelayTimeRemaining = gameMode.initialDelay;
    }
    _previousGameState = gameState;
    if (initialDelayTimeRemaining > 0) {
      initialDelayTimeRemaining -= dt;
      return;
    }

    // Try to spawn or switch to the upcoming game mode
    switch (gameMode) {
      case GameModeSingleSpawn():
        if (upComingGameMode != null) {
          return;
        }
        timeSinceLastSingleOrbSpawn += dt;
        final spawnOrbsEvery = gameMode.getSpawnOrbsEvery(
          difficultly,
        );
        if (timeSinceLastSingleOrbSpawn >= spawnOrbsEvery &&
            upComingGameMode == null) {
          timeSinceLastSingleOrbSpawn = 0.0;
          singleSpawn(gameMode);
        }
      case GameModeMultiSpawn():
        return;
    }
  }

  Vector2 _getRandomSpawnPositionAroundMap() {
    final distance = (game.size.x / 2) + (game.size.x * 0.05);
    final angle = Random().nextDouble() * pi * 2;
    return Vector2(cos(angle), sin(angle)) * distance;
  }

  // bool _shouldSpawnHeart() {
  //   if (!currentGameMode.canSpawnMovingHealth) {
  //     return false;
  //   }
  //   final missingHP = GameConstants.maxHealthPoints - bloc.state.healthPoints;
  //   if (missingHP == 0) {
  //     return false;
  //   }
  //   late double generateHealthChance;
  //   if (bloc.state.firstHealthReceived) {
  //     generateHealthChance = GameConstants.chanceToSpawnHeart;
  //   } else {
  //     if (_firstTimeHealthGeneratedCount <
  //         GameConstants.spawnHeartForFirstTimeMaxCount) {
  //       generateHealthChance = GameConstants.chanceToSpawnHeartForFirstTime;
  //     } else {
  //       generateHealthChance = GameConstants.chanceToSpawnHeart;
  //     }
  //     _firstTimeHealthGeneratedCount++;
  //   }

  //   return Random().nextDouble() <= generateHealthChance;
  // }

  // bool _tryToSpawnHealthPoint() {
  //   if (!_shouldSpawnHeart()) {
  //     return false;
  //   }
  //   // We can improve it later, it should not be depend on the orb speeds.
  //   // Or maybe it should?
  //   final moveSpeed = const GameModeSingleSpawn().getSpawnOrbsMoveSpeed(
  //     bloc.state.difficulty,
  //   );
  //   final healthMoveSpeed =
  //       (moveSpeed * GameConstants.movingHealthPointSpeedMultiplier).clamp(
  //     GameConstants.movingHealthMinSpeed,
  //     GameConstants.movingHealthMaxSpeed,
  //   );
  //   movingHealth!.removed.then((value) {
  //     movingHealth = null;
  //   });
  //   return true;
  // }

  void spawnOrbSpawner(GameModeMultiSpawn gameMode) {
    if (upComingGameMode != null) {
      return;
    }
    if (!playingState.isPlaying) {
      return;
    }
    final position = _getRandomSpawnPositionAroundMap();
    final difficulty = difficultly;
    final orbType = OrbType.values.random();
    final spawner = MultiOrbSpawner(
      position: position,
      spawnOrbsEvery: gameMode.getSpawnOrbsEvery(difficulty),
      spawnOrbsMoveSpeed: gameMode.getSpawnOrbsMoveSpeed(difficulty),
      orbType: orbType,
      target: player,
      spawnCount: gameMode.orbsSpawnCount(),
    );
    parent.add(spawner);
    aliveMultiOrbSpawners.add(spawner);

    if (Random().nextDouble() <= 2 / 3) {
      final oppositePosition = position.clone()..negate();
      final oppositeOrbType = switch (orbType) {
        OrbType.fire => OrbType.fire,
      };
      final oppositeSpawner = MultiOrbSpawner(
        position: oppositePosition,
        spawnOrbsEvery: gameMode.getSpawnOrbsEvery(difficulty),
        spawnOrbsMoveSpeed: gameMode.getSpawnOrbsMoveSpeed(difficulty),
        orbType: oppositeOrbType,
        target: player,
        spawnCount: gameMode.orbsSpawnCount(),
        isOpposite: true,
      );
      parent.add(oppositeSpawner);
      aliveMultiOrbSpawners.add(oppositeSpawner);
    }
  }

  void singleSpawn(GameModeSingleSpawn gameMode) {
    if (upComingGameMode != null) {
      return;
    }
    if (!playingState.isPlaying) {
      return;
    }
    final moveSpeed = gameMode.getSpawnOrbsMoveSpeed(difficultly);
    late MovingOrb orb;
    switch (OrbType.values.random()) {
      case OrbType.fire:
        orb = FireOrb(
          speed: moveSpeed,
          target: player,
          position: _getRandomSpawnPositionAroundMap(),
        );
    }
    parent.add(orb);
    aliveSingleMovingOrbs.add(orb);
  }
}
