import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_helper/converters/date_time_converter.dart';
import 'package:firebase_helper/firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tokyo_hackathon2024/firebase_options.dart';
import 'package:flutter_tokyo_hackathon2024/generated/assets.gen.dart';
import 'package:flutter_tokyo_hackathon2024/models/game_score/game_score_model.dart';
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
  const PlayGame({super.key, required this.userName});
  final String userName;

  @override
  _PlayGameState createState() => _PlayGameState();
}

class _PlayGameState extends ConsumerState<PlayGame> {
  FirebaseFirestoreHelper get _helper => FirebaseFirestoreHelper.instance;
  Timer? _timer;
  final ValueNotifier<int> _remainingTime =
      ValueNotifier<int>(20); // Valor inicial de 60 segundos

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.value > 0) {
        _remainingTime.value--; // Actualiza el valor del temporizador
      } else {
        timer.cancel(); // Detiene el temporizador
        showAlert(); // Muestra la alerta
      }
    });
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Tiempo terminado!'),
          content: const Text('El tiempo de juego ha finalizado.'),
          actions: [
            TextButton(
              onPressed: () async {
                final data = GameScoreModel(
                  userName: widget.userName,
                  score: ref.read(scoreProvider),
                );
                await _helper.set(
                  documentPath: GameScoreModel.documentPath(widget.userName),
                  data: data.toJson(),
                  setOptions: SetOptions(merge: true),
                );
                if (context.mounted) {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => const OnboardingPage(),
                    ),
                  );
                }
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // final gameStateNotifier = ref.read(gameStateProvider.notifier);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador cuando el widget se destruye
    _remainingTime.dispose(); // Libera el ValueNotifier
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    //final currentScore = ref.watch(scoreProvider);
    return Scaffold(
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
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Consumer(
                builder: (context, ref, _) {
                  final currentScore = ref.watch(scoreProvider);
                  return ValueListenableBuilder<int>(
                    valueListenable: _remainingTime,
                    builder: (context, time, child) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Score: $currentScore',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.person, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'User: ${widget.userName}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.timer, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Time: $time',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: time <= 5
                                  ? Colors.red
                                  : time <= 10
                                      ? Colors.orange
                                      : Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
