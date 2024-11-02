import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_state.dart';

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(),
);
