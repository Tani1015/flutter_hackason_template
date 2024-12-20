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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

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
    return MaterialApp(
      title: 'Flutter Hackathon 2024',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      theme: themeLight,
      darkTheme: themeDark,
      builder: (_, child) => AppWrapper(child!),
      home: Scaffold(
        body: OnboardingPage()
      ),
    );
  }
}
