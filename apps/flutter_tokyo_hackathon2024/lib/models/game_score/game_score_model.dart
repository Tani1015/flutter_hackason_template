// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_score_model.freezed.dart';
part 'game_score_model.g.dart';

@freezed
class GameScoreModel with _$GameScoreModel {
  const factory GameScoreModel({
    required String userName,
    required int score,
  }) = _GameScoreModel;

  const GameScoreModel._();

  factory GameScoreModel.fromJson(Map<String, Object?> json) =>
      _$GameScoreModelFromJson(json);

  static String get collectionPath => 'users';

  static String documentPath(String userName) => '$collectionPath/$userName/';
}
