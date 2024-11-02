import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/game_state/game_state_notifier.dart';
import '../neko_game.dart';
import '../widget/rotation_controls.dart';

final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    final gameStateNotifier = ref.read(gameStateProvider.notifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          RiverpodAwareGameWidget(
            key: gameWidgetKey,
            game: NekoGame(),
          ),
          RotationControls(
            showGuide: true,
            onLeftDown: ref.read(gameStateProvider.notifier).onLeftTapDown,
            onLeftUp: ref.read(gameStateProvider.notifier).onLeftTapUp,
            onRightDown: ref.read(gameStateProvider.notifier).onRightTapDown,
            onRightUp: ref.read(gameStateProvider.notifier).onRightTapUp,
          ),
        ],
      ),
    );
  }
}
