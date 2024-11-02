import 'package:flame/components.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/moving_component.dart';
import 'package:flutter_tokyo_hackathon2024/game/components/moving/orb/orb_type.dart';
import 'package:flutter_tokyo_hackathon2024/game/neko_game.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/game_state/game_state_notifier.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/playing_state.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

class MultiOrbSpawner extends PositionComponent
    with ParentIsA<MyWorld>, RiverpodComponentMixin {
  MultiOrbSpawner({
    super.position,
    required this.spawnOrbsEvery,
    required this.spawnOrbsMoveSpeed,
    required this.orbType,
    required this.target,
    required this.spawnCount,
    this.isOpposite = false,
  });
  final double spawnOrbsEvery;
  final double spawnOrbsMoveSpeed;
  final OrbType orbType;
  final PositionComponent target;
  final int spawnCount;
  final bool isOpposite;

  bool firstSpawned = false;
  double timeSinceLastSpawn = 0;

  int spawnedCount = 0;

  List<MovingOrb> aliveMovingOrbs = [];

  PlayingState get playingState => ref.read(gameStateProvider).playingState;

  @override
  void update(double dt) {
    super.update(dt);
    if (playingState is! PlayingStatePlaying) {
      return;
    }

    final spawnFinished = spawnedCount >= spawnCount;
    aliveMovingOrbs.removeWhere((e) => e.isRemoved);
    if (spawnFinished) {
      if (aliveMovingOrbs.isEmpty) {
        removeFromParent();
      }
      return;
    }
    if (isRemoved) {
      return;
    }
    if (!firstSpawned) {
      firstSpawned = true;
      spawnOrb();
      return;
    }
    timeSinceLastSpawn += dt;
    if (timeSinceLastSpawn >= spawnOrbsEvery) {
      timeSinceLastSpawn = 0;
      spawnOrb();
    }
  }

  void spawnOrb() {
    late MovingOrb orb;
    switch (orbType) {
      case OrbType.fire:
        orb = FireOrb(
          speed: spawnOrbsMoveSpeed,
          target: target,
          position: position,
          overrideCollisionSoundNumber: isOpposite ? -1 : spawnedCount % 6,
        );
    }
    aliveMovingOrbs.add(orb);
    parent.add(orb);
    spawnedCount++;
  }
}
