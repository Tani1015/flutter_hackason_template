import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'game_mode.dart';
import 'game_mode_notifier.dart';

class GameModeNotifier extends StateNotifier<GameMode> {
  GameModeNotifier() : super(const GameModeSingleSpawn());

  // Only one spawner
  void switchToSingleSpawnMode() {
    state = const GameModeSingleSpawn();
  }

  // change mode to multiple spawn 
  void switchToMultiSpawnMode(int spawnerCount) {
    state = GameModeMultiSpawn(spawnerSpawnCount: spawnerCount);
  }

  // update the passed time
  void updatePassedTime(double dt) {
    state = state.updatePassedTime(dt);
  }

  // increse the defended orbs count
  void increaseDefendedOrbsCount(int count) {
    state = state.increaseDefendedOrbsCount(count: count);
  }

  // Increse the collided orbs count
  void increaseCollidedOrbsCount(int count) {
    state = state.increaseCollidedOrbsCount(count: count);
  }

  // increse the orbet
  void increaseDefendOrbStreakCount(int count) {
    state = state.increaseDefendOrbStreakCount(count: count);
  }

  // Reset the score streak
  void resetDefendOrbStreakCount() {
    state = state.resetDefendOrbStreakCount();
  }

  // update initial delay
  void updateInitialDelay(double delay) {
    state = state.updateInitialDelay(delay);
  }
}