import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/firebase_options.dart';
import 'package:flutter_tokyo_hackathon2024/generated/assets.gen.dart';
import 'package:flutter_tokyo_hackathon2024/presentation/pages/onboarding/onboarding_page.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/playing_state_notifier.dart';
import 'package:flutter_tokyo_hackathon2024/riverpod/score_notifier.dart';
import 'package:helper/presentation/app/navigator_handler.dart';
import 'package:helper/presentation/app_wrapper.dart';
import 'package:helper/presentation/widgets/lottie.dart';
import 'package:helper/res/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

import 'game/neko_game.dart';
import 'game/widget/rotation_controls.dart';
import 'riverpod/game_state/game_state_notifier.dart';
import 'riverpod/playing_state.dart';

final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState>();

class PlayGame extends ConsumerStatefulWidget {
    final String userName;
  const PlayGame({super.key, required this.userName});

  @override
  ConsumerState<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends ConsumerState<PlayGame> {
  @override
  void initState() {
    final gameStateNotifier = ref.read(gameStateProvider.notifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    final gameState = ref.watch(gameStateProvider);
    final playingState = ref.watch(playingStateProvider);
    int currentScore = 0;

    if (playingState is PlayingStateNone) {
      print('update score');
      currentScore = ref.read(playingStateProvider.notifier).currentScore.value;
    }else{
       print('no update score');
    }
    return  Scaffold(
        body: Stack(
          children: [
            RiverpodAwareGameWidget(
              key: gameWidgetKey,
              game: NekoGame(),
              overlayBuilderMap: {
                'LottieOverlay': (BuildContext context, _) {
                  return Center(
                    child: ImmediatelyLottie(
                      Assets.json.cat.path,
                      width: screenWidth * 0.1,
                    ),
                  );
                },
              },
            ),
            // RotationControls(
            //   showGuide: false,
            //   onLeftDown: ref.read(gameStateProvider.notifier).onLeftTapDown,
            //   onLeftUp: ref.read(gameStateProvider.notifier).onLeftTapUp,
            //   onRightDown: ref.read(gameStateProvider.notifier).onRightTapDown,
            //   onRightUp: ref.read(gameStateProvider.notifier).onRightTapUp,
            // ),
             Positioned(
              top: 20,
              left: 20,
              child: Consumer(
                builder: (context, ref, _) {
                final currentScore = ref.watch(scoreProvider);
                
                  return Text(
                    'Score: $currentScore user: ${widget.userName}' ,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
