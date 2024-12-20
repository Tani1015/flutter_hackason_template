

// import 'package:nekoprotect/riverpod/playing_state.dart';

// class ScoresRepository {
//   final ScoresLocalDataSource _scoresLocalDataSource;
//   final ScoresRemoteDataSource _scoresRemoteDataSource;

//   ScoresRepository(
//     this._scoresLocalDataSource,
//     this._scoresRemoteDataSource,
//   );

//   // Future<OnlineScoreEntity> saveScore(int scoreMilliseconds) async {
//   //   final currentLocalScore = await _scoresLocalDataSource.getHighScore();
//   //   final newLocalScore = switch (currentLocalScore) {
//   //     null => OfflineScoreEntity(score: scoreMilliseconds),
//   //     OfflineScoreEntity() =>
//   //       currentLocalScore.copyWith(score: scoreMilliseconds),
//   //     OnlineScoreEntity() =>
//   //       currentLocalScore.copyWith(score: scoreMilliseconds),
//   //   };
//   //   await _scoresLocalDataSource.setHighScore(newLocalScore);
//   //   final score = await _scoresRemoteDataSource.submitScore(scoreMilliseconds);
//   //   await _scoresLocalDataSource.setHighScore(score);
//   //   return score;
//   // }

//   Future<ScoreEntity?> syncHighScore() async {
//     final myRemoteScore = await _scoresRemoteDataSource.getScore();
//     final myLocalScore = await _scoresLocalDataSource.getHighScore();

//     // Both are null
//     if (myRemoteScore == null && myLocalScore == null) {
//       final scoreEntity = await _scoresRemoteDataSource.submitScore(0);
//       await _scoresLocalDataSource.setHighScore(scoreEntity);
//       return scoreEntity;
//     }

//     // One is null
//     if (myRemoteScore == null && myLocalScore != null) {
//       final newRemoteScore = await _scoresRemoteDataSource.submitScore(
//         myLocalScore.score,
//       );
//       await _scoresLocalDataSource.setHighScore(newRemoteScore);
//       return newRemoteScore;
//     }

//     if (myRemoteScore != null && myLocalScore == null) {
//       return await _scoresLocalDataSource.setHighScore(
//         myRemoteScore,
//       );
//     }

//     // Both are not null
//     if (myRemoteScore!.score == myLocalScore!.score) {
//       /// We override the remote score with the local score
//       /// Because rank might be changed on the server
//       await _scoresLocalDataSource.setHighScore(myRemoteScore);
//       return myRemoteScore;
//     } else if (myRemoteScore.score > myLocalScore.score) {
//       return await _scoresLocalDataSource.setHighScore(
//         myRemoteScore,
//       );
//     } else {
//       final newRemoteScore =
//           await _scoresRemoteDataSource.submitScore(myLocalScore.score);
//       await _scoresLocalDataSource.setHighScore(newRemoteScore);
//       return newRemoteScore;
//     }
//   }

//   Future<ScoreEntity> getHighScore() async =>
//       (await _scoresLocalDataSource.getHighScore()) ??
//       OfflineScoreEntity(score: 0);

//   Stream<ScoreEntity> getHighScoreStream() =>
//       _scoresLocalDataSource.getHighScoreStream();

//   Future<LeaderboardResponseEntity> getLeaderboard(
//     int pageLimit,
//     String? pageLastId,
//   ) =>
//       _scoresRemoteDataSource.getLeaderboard(pageLimit, pageLastId);
// }
