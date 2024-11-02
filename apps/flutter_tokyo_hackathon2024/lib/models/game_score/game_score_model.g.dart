// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameScoreModelImpl _$$GameScoreModelImplFromJson(Map<String, dynamic> json) =>
    _$GameScoreModelImpl(
      userName: json['userName'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$$GameScoreModelImplToJson(
        _$GameScoreModelImpl instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'score': instance.score,
    };
