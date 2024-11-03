import 'package:firebase_helper/converters/date_time_converter.dart';
import 'package:riverpod/riverpod.dart';

import '../game/components/score_entity.dart';

class ScoreNotifier extends StateNotifier<int> {
  ScoreNotifier() : super(3);

  void increment(int value) {
    state += value;
  }

  void decrement(int value) {
    state = (state - value).clamp(0, double.infinity).toInt();
    if (state == 0) {
      _handleGameOver();
    }
  }

    void _handleGameOver() {

    FirebaseFirestore.instance.collection('scores').add({
      'score': state,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      print('Score saved to Firebase');
    }).catchError((error) {
      print('Failed to save score: $error');
    });
  }

  void reset() {
    state = 0;
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, int>(
  (ref) => ScoreNotifier(),
);