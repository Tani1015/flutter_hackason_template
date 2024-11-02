// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_score_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameScoreModel _$GameScoreModelFromJson(Map<String, dynamic> json) {
  return _GameScoreModel.fromJson(json);
}

/// @nodoc
mixin _$GameScoreModel {
  String get userName => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;

  /// Serializes this GameScoreModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameScoreModelCopyWith<GameScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameScoreModelCopyWith<$Res> {
  factory $GameScoreModelCopyWith(
          GameScoreModel value, $Res Function(GameScoreModel) then) =
      _$GameScoreModelCopyWithImpl<$Res, GameScoreModel>;
  @useResult
  $Res call({String userName, int score});
}

/// @nodoc
class _$GameScoreModelCopyWithImpl<$Res, $Val extends GameScoreModel>
    implements $GameScoreModelCopyWith<$Res> {
  _$GameScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? score = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameScoreModelImplCopyWith<$Res>
    implements $GameScoreModelCopyWith<$Res> {
  factory _$$GameScoreModelImplCopyWith(_$GameScoreModelImpl value,
          $Res Function(_$GameScoreModelImpl) then) =
      __$$GameScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, int score});
}

/// @nodoc
class __$$GameScoreModelImplCopyWithImpl<$Res>
    extends _$GameScoreModelCopyWithImpl<$Res, _$GameScoreModelImpl>
    implements _$$GameScoreModelImplCopyWith<$Res> {
  __$$GameScoreModelImplCopyWithImpl(
      _$GameScoreModelImpl _value, $Res Function(_$GameScoreModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? score = null,
  }) {
    return _then(_$GameScoreModelImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameScoreModelImpl extends _GameScoreModel {
  const _$GameScoreModelImpl({required this.userName, required this.score})
      : super._();

  factory _$GameScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameScoreModelImplFromJson(json);

  @override
  final String userName;
  @override
  final int score;

  @override
  String toString() {
    return 'GameScoreModel(userName: $userName, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameScoreModelImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.score, score) || other.score == score));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userName, score);

  /// Create a copy of GameScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameScoreModelImplCopyWith<_$GameScoreModelImpl> get copyWith =>
      __$$GameScoreModelImplCopyWithImpl<_$GameScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameScoreModelImplToJson(
      this,
    );
  }
}

abstract class _GameScoreModel extends GameScoreModel {
  const factory _GameScoreModel(
      {required final String userName,
      required final int score}) = _$GameScoreModelImpl;
  const _GameScoreModel._() : super._();

  factory _GameScoreModel.fromJson(Map<String, dynamic> json) =
      _$GameScoreModelImpl.fromJson;

  @override
  String get userName;
  @override
  int get score;

  /// Create a copy of GameScoreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameScoreModelImplCopyWith<_$GameScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
