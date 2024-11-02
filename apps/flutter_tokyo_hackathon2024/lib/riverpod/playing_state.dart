import 'package:equatable/equatable.dart';


abstract class PlayingState extends Equatable {
  const PlayingState();

  bool get isGuide => this is PlayingStateGuide;
  bool get isNone => this is PlayingStateNone;
  bool get isGameOver => this is PlayingStateGameOver;
  bool get isPlaying => this is PlayingStatePlaying;
  bool get isPaused => this is PlayingStatePaused;

  @override
  List<Object?> get props => [];
}

class PlayingStateNone extends PlayingState {
  const PlayingStateNone();
}

class PlayingStateGuide extends PlayingState {
  const PlayingStateGuide();
}

class PlayingStatePlaying extends PlayingState {
  const PlayingStatePlaying();
}

class PlayingStatePaused extends PlayingState {
  const PlayingStatePaused();
}

class PlayingStateGameOver extends PlayingState {
  final ScoreEntity score;
  final bool isHighScore;
  final ScoreEntity highestScore;

  const PlayingStateGameOver({
    required this.score,
    required this.isHighScore,
    required this.highestScore,
  });

  @override
  List<Object?> get props => [score, isHighScore, highestScore];
}

class ScoreEntity extends Equatable {
  final int value;

  const ScoreEntity(this.value);

  @override
  List<Object?> get props => [value];
}

