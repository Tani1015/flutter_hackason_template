// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helper/logger/logger.dart';

// import 'package:equatable/equatable.dart';
import '../../game/components/moving/moving_component.dart';
// import '../../game/entities/value_wrapper.dart';
import '../../game/model/domain_error.dart';
import '../../game/motivation/motivation_component.dart';
import '../../game_constants.dart';
import '../playing_state.dart';
import 'game_mode.dart';

class GameState extends Equatable {
  const GameState({
    this.healthPoints = GameConstants.maxHealthPoints,
    this.levelTimePassed = 0,
    this.difficultyTimePassed = 0,
    this.playingState = const PlayingStateNone(),
    this.showGameOverUI = false,
    this.restartGame = false,
    this.onNewHighScore,
    this.firstHealthReceived = false,
    this.shieldHitCounter = 0,
    this.gameModeHistory = const [],
    this.currentGameMode = const GameModeSingleSpawn(),
    this.upcomingGameMode,
    this.playMotivationWord,
    this.motivationWordsPoolToPlay = MotivationWordType.values,
  });

  final int healthPoints;
  final double levelTimePassed;
  final double difficultyTimePassed;
  final PlayingState playingState;
  final bool showGameOverUI;
  final bool restartGame;
  final OnlineScoreEntity? onNewHighScore;
  final bool firstHealthReceived;
  final int shieldHitCounter;
  final List<GameMode> gameModeHistory;
  final GameMode currentGameMode;
  final GameMode? upcomingGameMode;
  final MotivationWordType? playMotivationWord;
  final List<MotivationWordType> motivationWordsPoolToPlay;

  // Calculated properties
  double get difficulty => GameConstants.difficultyInitialToPeakCurve.transform(
        min(
          1,
          difficultyTimePassed / GameConstants.difficultyInitialToPeakDuration,
        ),
      );

  double get gameOverTimeScale {
    if (playingState.isPaused) {
      return 0;
    }
    if (playingState.isGameOver) {
      return showGameOverUI ? 0.0 : GameConstants.gameOverTimeScale;
    }
    return 1;
  }

  GameState copyWith({
    int? healthPoints,
    double? levelTimePassed,
    double? difficultyTimePassed,
    PlayingState? playingState,
    bool? showGameOverUI,
    bool? restartGame,
    OnlineScoreEntity? onNewHighScore,
    bool? firstHealthReceived,
    int? shieldHitCounter,
    List<GameMode>? gameModeHistory,
    GameMode? currentGameMode,
    GameMode? upcomingGameMode,
    MotivationWordType? playMotivationWord,
    List<MotivationWordType>? motivationWordsPoolToPlay,
  }) {
    return GameState(
      healthPoints: healthPoints ?? this.healthPoints,
      levelTimePassed: levelTimePassed ?? this.levelTimePassed,
      difficultyTimePassed: difficultyTimePassed ?? this.difficultyTimePassed,
      playingState: playingState ?? this.playingState,
      showGameOverUI: showGameOverUI ?? this.showGameOverUI,
      restartGame: restartGame ?? this.restartGame,
      onNewHighScore: onNewHighScore ?? this.onNewHighScore,
      firstHealthReceived: firstHealthReceived ?? this.firstHealthReceived,
      shieldHitCounter: shieldHitCounter ?? this.shieldHitCounter,
      gameModeHistory: gameModeHistory ?? this.gameModeHistory,
      currentGameMode: currentGameMode ?? this.currentGameMode,
      upcomingGameMode: upcomingGameMode ?? this.upcomingGameMode,
      playMotivationWord: playMotivationWord ?? this.playMotivationWord,
      motivationWordsPoolToPlay:
          motivationWordsPoolToPlay ?? this.motivationWordsPoolToPlay,
    );
  }

  @override
  List<Object?> get props => [
        healthPoints,
        levelTimePassed,
        difficultyTimePassed,
        playingState,
        showGameOverUI,
        restartGame,
        onNewHighScore,
        firstHealthReceived,
        shieldHitCounter,
        gameModeHistory,
        currentGameMode,
        upcomingGameMode,
        playMotivationWord,
        motivationWordsPoolToPlay,
      ];
}

// StateNotifier para GameState
class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(const GameState());

  final double _shieldAngleRotationAmount = pi * 1.8;

  static double shieldsAngleRotationSpeed = 0;

  // final ScoresRepository _scoresRepository;
  //final ConfigsRepository _configsRepository;

  bool isTapLeftDown = false;
  bool isTapRightDown = false;

  late int gameShowGuideTimestamp;
  late int gameStartedTimestamp;

  void startToShowGuide() {
    gameShowGuideTimestamp = DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith(playingState: const PlayingStateGuide());
    // state = state.copyWith(
    //   firstHealthReceived: await _configsRepository.isFirstHealthReceived(),
    // );
  }

  void _guideInteracted() {
    if (!state.playingState.isGuide) {
      return;
    }
    gameStartedTimestamp = DateTime.now().millisecondsSinceEpoch;
    // final afterGuideDurationMills =
    //     gameStartedTimestamp - gameShowGuideTimestamp;
    state = state.copyWith(playingState: const PlayingStatePlaying());
  }

  void update(double dt) {
    if (!state.playingState.isPlaying) {
      return;
    }
    state = state.copyWith(
      levelTimePassed: state.levelTimePassed + dt,
      currentGameMode: state.currentGameMode.updatePassedTime(dt),
    );
    if (state.currentGameMode.increasesDifficulty) {
      state = state.copyWith(
        difficultyTimePassed: state.difficultyTimePassed + dt,
      );
    }
  }

  void _tryToSwitchToMultiSpawnGameMode() {
    if (state.currentGameMode is GameModeMultiSpawn ||
        state.upcomingGameMode != null) {
      return;
    }
    if (state.difficulty < 0.5 ||
        Random().nextDouble() > GameConstants.multiShieldGameModeChance) {
      return;
    }

    final count = Random().nextInt(4) + 2;
    state = state.copyWith(
      upcomingGameMode: const GameModeSingleSpawn(),
    );
  }

  void potatoOrbHit() {
    var updatedGameMode =
        state.currentGameMode.increaseCollidedOrbsCount(count: 1);
    updatedGameMode = updatedGameMode.resetDefendOrbStreakCount();
    state = state.copyWith(
      healthPoints: max(0, state.healthPoints - 1),
      currentGameMode: updatedGameMode,
    );
    if (state.healthPoints <= 0) {
      _gameOver();
    }
  }

  void onPotatoHealthPointReceived() {
    state = state.copyWith(
      healthPoints: min(GameConstants.maxHealthPoints, state.healthPoints + 1),
      firstHealthReceived: true,
    );
    // _configsRepository.setFirstHealthReceived(true);
  }

  Future<void> _gameOver() async {
    // final score = (state.levelTimePassed * 1000).toInt();
    //  final previousScore = await _scoresRepository.getHighScore();
    // final isHighScore = score > previousScore.score;

    // OnlineScoreEntity? tempOnlineScore;
    // if (isHighScore && previousScore is OnlineScoreEntity) {
    //   tempOnlineScore = previousScore.copyWith(score: score);
    // }

    // final highestScore = isHighScore ? tempOnlineScore ?? OfflineScoreEntity(score: score) : previousScore;
    // //game over
    // // state = state.copyWith(
    // //   playingState: PlayingStateGameOver(score: tempOnlineScore ?? OfflineScoreEntity(score: score), isHighScore: isHighScore, highestScore: highestScore),
    // // );
    // _submitScore(previousScore);

    state = state.copyWith(showGameOverUI: true);
  }

  // Future<void> _submitScore(ScoreEntity previousScore) async {
  //   try {
  //     final score = (state.levelTimePassed * 1000).toInt();
  //     if (score > previousScore.score) {
  // final newScore = await _scoresRepository.saveScore(score);
  // if (previousScore is OnlineScoreEntity && newScore.rank < previousScore.rank) {

  //   if (state.playingState is PlayingStateGameOver) {
  //     state = state.copyWith(
  //       playingState: PlayingStateGameOver(score: newScore, isHighScore: true, highestScore: newScore),
  //     );
  //   }
  //   state = state.copyWith(onNewHighScore: newScore);
  //   state = state.copyWith(onNewHighScore: null);
  // }
  // }
  //   } catch (e) {
  //     if (e is! NetworkError) rethrow;
  //   }
  // }

  void _updateShieldsRotationSpeed(double speed) {
    shieldsAngleRotationSpeed = speed.clamp(
      -_shieldAngleRotationAmount,
      _shieldAngleRotationAmount,
    );
  }

  void onLeftTapDown() {
    isTapLeftDown = true;
    _guideInteracted();
    _updateShieldsRotationSpeed(-_shieldAngleRotationAmount);
  }

  void onLeftTapUp() {
    isTapLeftDown = false;
    _updateShieldsRotationSpeed(
      isTapRightDown ? _shieldAngleRotationAmount : 0.0,
    );
  }

  void onRightTapDown() {
    isTapRightDown = true;
    _guideInteracted();
    _updateShieldsRotationSpeed(_shieldAngleRotationAmount);
  }

  void onRightTapUp() {
    isTapRightDown = false;
    _updateShieldsRotationSpeed(
      isTapLeftDown ? -_shieldAngleRotationAmount : 0.0,
    );
  }

  KeyEventResult handleKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final containsLeftArrow = keysPressed.contains(
      LogicalKeyboardKey.arrowLeft,
    );

    final containsRightArrow = keysPressed.contains(
      LogicalKeyboardKey.arrowRight,
    );

    if (containsLeftArrow || containsRightArrow) {
      _guideInteracted();
    }
    // ignore: omit_local_variable_types
    double rotationSpeed = 0;
    if (!containsRightArrow && !containsLeftArrow) {
      _updateShieldsRotationSpeed(0);
      return KeyEventResult.handled;
    }

    if (containsLeftArrow) {
      rotationSpeed -= _shieldAngleRotationAmount;
    }
    if (containsRightArrow) {
      rotationSpeed += _shieldAngleRotationAmount;
    }

    if (rotationSpeed != 0) {
      _updateShieldsRotationSpeed(
        rotationSpeed,
      );
      return KeyEventResult.handled;
    }

    logger.warning(rotationSpeed);

    return KeyEventResult.ignored;
  }

  void pauseGame({required bool manually}) {
    if (!state.playingState.isPlaying) {
      throw StateError('State is not playing');
    }

    state = state.copyWith(playingState: const PlayingStatePaused());
  }

  void resumeGame() {
    state = state.copyWith(playingState: const PlayingStatePlaying());
  }

  void restartGame() {
    state = const GameState()
        .copyWith(playingState: const PlayingStateGuide(), restartGame: true);
    state = state.copyWith(restartGame: false);
  }

  void onShieldHit(MovingComponent movingComponent) {
    if (movingComponent is FireOrb) {
      var updatedGameMode =
          state.currentGameMode.increaseDefendedOrbsCount(count: 1);
      updatedGameMode = updatedGameMode.increaseDefendOrbStreakCount(count: 1);
      state = state.copyWith(
        shieldHitCounter: state.shieldHitCounter + 1,
        currentGameMode: updatedGameMode,
      );
    }
    if (state.shieldHitCounter % GameConstants.tryToSwitchGameModeEvery == 0) {
      _tryToSwitchToMultiSpawnGameMode();
    }
  }
}

sealed class ScoreEntity with EquatableMixin {
  abstract final int score;

  static ScoreEntity fromJson(Map<String, dynamic> jsonDecode) =>
      switch (jsonDecode['type']) {
        OfflineScoreEntity._type => OfflineScoreEntity.fromJson(
            jsonDecode,
          ),
        OnlineScoreEntity._type => OnlineScoreEntity.fromJson(
            jsonDecode,
          ),
        _ => throw Exception(
            'Unknown type ${jsonDecode['type']}',
          ),
      };

  Map<String, dynamic> toJson() => throw UnimplementedError();
}

class OfflineScoreEntity extends ScoreEntity {
  OfflineScoreEntity({
    required this.score,
  });

  factory OfflineScoreEntity.fromJson(Map<String, dynamic> json) =>
      OfflineScoreEntity(
        score: json['score'] as int,
      );
  static const _type = 'offline';

  @override
  final int score;

  OfflineScoreEntity copyWith({
    int? score,
  }) =>
      OfflineScoreEntity(
        score: score ?? this.score,
      );

  @override
  Map<String, dynamic> toJson() => {
        'score': score,
        'type': _type,
      };

  @override
  List<Object?> get props => [score];
}

class OnlineScoreEntity extends ScoreEntity {
  OnlineScoreEntity({
    required this.score,
    required this.userId,
    required this.nickname,
    required this.isMine,
    required this.rank,
  });

  factory OnlineScoreEntity.fromJson(Map<String, dynamic> json) =>
      OnlineScoreEntity(
        score: json['score'] as int,
        userId: json['user_id'] as String,
        nickname: json['nickname'] as String,
        isMine: json['is_mine'] as bool,
        rank: json['rank'] as int,
      );
  static const _type = 'online';

  @override
  final int score;
  final String userId;
  final String nickname;
  final bool isMine;
  final int rank;

  /// id is the same as [userId] in the database
  String get id => userId;

  OnlineScoreEntity copyWith({
    int? score,
    String? userId,
    String? nickname,
    bool? isMine,
    int? rank,
  }) =>
      OnlineScoreEntity(
        score: score ?? this.score,
        userId: userId ?? this.userId,
        nickname: nickname ?? this.nickname,
        isMine: isMine ?? this.isMine,
        rank: rank ?? this.rank,
      );

  @override
  Map<String, dynamic> toJson() => {
        'type': _type,
        'score': score,
        'user_id': userId,
        'nickname': nickname,
        'is_mine': isMine,
        'rank': rank,
      };

  @override
  List<Object?> get props => [
        score,
        userId,
        nickname,
        isMine,
        rank,
      ];
}

class ValueWrapper<T> with EquatableMixin {
  const ValueWrapper(this.value);

  factory ValueWrapper.nullValue() => const ValueWrapper(null);
  final T? value;

  T get nonNullValue => value!;

  bool get isNull => value == null;

  bool get isNotNull => !isNull;

  @override
  List<Object?> get props => [value];
}
