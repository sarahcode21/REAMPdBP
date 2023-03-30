// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Level _$LevelFromJson(Map<String, dynamic> json) {
  return _Level.fromJson(json);
}

/// @nodoc
class _$LevelTearOff {
  const _$LevelTearOff();

  _Level call(
      {required String levelConfigID,
      List<LevelResult> results = const <LevelResult>[],
      int sessionsNeededForCompletion = kLevelSessionsNeededForCompletion}) {
    return _Level(
      levelConfigID: levelConfigID,
      results: results,
      sessionsNeededForCompletion: sessionsNeededForCompletion,
    );
  }

  Level fromJson(Map<String, Object?> json) {
    return Level.fromJson(json);
  }
}

/// @nodoc
const $Level = _$LevelTearOff();

/// @nodoc
mixin _$Level {
  String get levelConfigID => throw _privateConstructorUsedError;
  List<LevelResult> get results => throw _privateConstructorUsedError;
  int get sessionsNeededForCompletion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelCopyWith<Level> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelCopyWith<$Res> {
  factory $LevelCopyWith(Level value, $Res Function(Level) then) =
      _$LevelCopyWithImpl<$Res>;
  $Res call(
      {String levelConfigID,
      List<LevelResult> results,
      int sessionsNeededForCompletion});
}

/// @nodoc
class _$LevelCopyWithImpl<$Res> implements $LevelCopyWith<$Res> {
  _$LevelCopyWithImpl(this._value, this._then);

  final Level _value;
  // ignore: unused_field
  final $Res Function(Level) _then;

  @override
  $Res call({
    Object? levelConfigID = freezed,
    Object? results = freezed,
    Object? sessionsNeededForCompletion = freezed,
  }) {
    return _then(_value.copyWith(
      levelConfigID: levelConfigID == freezed
          ? _value.levelConfigID
          : levelConfigID // ignore: cast_nullable_to_non_nullable
              as String,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<LevelResult>,
      sessionsNeededForCompletion: sessionsNeededForCompletion == freezed
          ? _value.sessionsNeededForCompletion
          : sessionsNeededForCompletion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$LevelCopyWith<$Res> implements $LevelCopyWith<$Res> {
  factory _$LevelCopyWith(_Level value, $Res Function(_Level) then) =
      __$LevelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String levelConfigID,
      List<LevelResult> results,
      int sessionsNeededForCompletion});
}

/// @nodoc
class __$LevelCopyWithImpl<$Res> extends _$LevelCopyWithImpl<$Res>
    implements _$LevelCopyWith<$Res> {
  __$LevelCopyWithImpl(_Level _value, $Res Function(_Level) _then)
      : super(_value, (v) => _then(v as _Level));

  @override
  _Level get _value => super._value as _Level;

  @override
  $Res call({
    Object? levelConfigID = freezed,
    Object? results = freezed,
    Object? sessionsNeededForCompletion = freezed,
  }) {
    return _then(_Level(
      levelConfigID: levelConfigID == freezed
          ? _value.levelConfigID
          : levelConfigID // ignore: cast_nullable_to_non_nullable
              as String,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<LevelResult>,
      sessionsNeededForCompletion: sessionsNeededForCompletion == freezed
          ? _value.sessionsNeededForCompletion
          : sessionsNeededForCompletion // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Level extends _Level {
  _$_Level(
      {required this.levelConfigID,
      this.results = const <LevelResult>[],
      this.sessionsNeededForCompletion = kLevelSessionsNeededForCompletion})
      : super._();

  factory _$_Level.fromJson(Map<String, dynamic> json) =>
      _$$_LevelFromJson(json);

  @override
  final String levelConfigID;
  @JsonKey()
  @override
  final List<LevelResult> results;
  @JsonKey()
  @override
  final int sessionsNeededForCompletion;

  @override
  String toString() {
    return 'Level(levelConfigID: $levelConfigID, results: $results, sessionsNeededForCompletion: $sessionsNeededForCompletion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Level &&
            const DeepCollectionEquality()
                .equals(other.levelConfigID, levelConfigID) &&
            const DeepCollectionEquality().equals(other.results, results) &&
            const DeepCollectionEquality().equals(
                other.sessionsNeededForCompletion,
                sessionsNeededForCompletion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(levelConfigID),
      const DeepCollectionEquality().hash(results),
      const DeepCollectionEquality().hash(sessionsNeededForCompletion));

  @JsonKey(ignore: true)
  @override
  _$LevelCopyWith<_Level> get copyWith =>
      __$LevelCopyWithImpl<_Level>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LevelToJson(this);
  }
}

abstract class _Level extends Level {
  factory _Level(
      {required String levelConfigID,
      List<LevelResult> results,
      int sessionsNeededForCompletion}) = _$_Level;
  _Level._() : super._();

  factory _Level.fromJson(Map<String, dynamic> json) = _$_Level.fromJson;

  @override
  String get levelConfigID;
  @override
  List<LevelResult> get results;
  @override
  int get sessionsNeededForCompletion;
  @override
  @JsonKey(ignore: true)
  _$LevelCopyWith<_Level> get copyWith => throw _privateConstructorUsedError;
}
