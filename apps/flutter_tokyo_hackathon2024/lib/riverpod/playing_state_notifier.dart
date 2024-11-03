import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'playing_state.dart';

class PlayingStateNotifier extends StateNotifier<PlayingState> {
  PlayingStateNotifier() : super(const PlayingStateNone());

  ScoreEntity _currentScore = const ScoreEntity(0);
  void setGuide() => state = const PlayingStateGuide();

  void setPlaying() {
    _currentScore = const ScoreEntity(0);
    state = const PlayingStatePlaying();
  }

  void setPaused() => state = const PlayingStatePaused();

  void setGameOver(ScoreEntity score, bool isHighScore, ScoreEntity highestScore) {
    state = PlayingStateGameOver(
      score: score,
      isHighScore: isHighScore,
      highestScore: highestScore,
    );
  }

  void reset() => state = const PlayingStateNone();

  void incrementScore(int value) {
    print(value);
   // if (state is PlayingStateNone) {
      _currentScore = ScoreEntity(_currentScore.value + value);
   // }
  }
  void decrementScore(int value) {
    print(value);
    //if (state is PlayingStateNone) {
      final newValue = (_currentScore.value - value).clamp(0, double.infinity).toInt();
      _currentScore = ScoreEntity(newValue);
      
   // }
  }

  // Obtener el puntaje actual
  ScoreEntity get currentScore => _currentScore;

}


final playingStateProvider = StateNotifierProvider<PlayingStateNotifier, PlayingState>(
  (ref) => PlayingStateNotifier(),
);