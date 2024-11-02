import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'playing_state.dart';

class PlayingStateNotifier extends StateNotifier<PlayingState> {
  PlayingStateNotifier() : super(const PlayingStateNone());

  void setGuide() => state = const PlayingStateGuide();

  void setPlaying() => state = const PlayingStatePlaying();

  void setPaused() => state = const PlayingStatePaused();

  void setGameOver(ScoreEntity score, bool isHighScore, ScoreEntity highestScore) {
    state = PlayingStateGameOver(
      score: score,
      isHighScore: isHighScore,
      highestScore: highestScore,
    );
  }

  void reset() => state = const PlayingStateNone();
}
final playingStateProvider = StateNotifierProvider<PlayingStateNotifier, PlayingState>(
  (ref) => PlayingStateNotifier(),
);