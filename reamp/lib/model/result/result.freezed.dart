// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LevelResult _$LevelResultFromJson(Map<String, dynamic> json) {
  return _LevelResult.fromJson(json);
}

/// @nodoc
class _$LevelResultTearOff {
  const _$LevelResultTearOff();

  _LevelResult call(
      {@DateTimeConverter() required DateTime time, required double tension}) {
    return _LevelResult(
      time: time,
      tension: tension,
    );
  }

  LevelResult fromJson(Map<String, Object?> json) {
    return LevelResult.fromJson(json);
  }
}

/// @nodoc
const $LevelResult = _$LevelResultTearOff();

/// @nodoc
mixin _$LevelResult {
  @DateTimeConverter()
  DateTime get time => throw _privateConstructorUsedError;
  double get tension => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LevelResultCopyWith<LevelResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LevelResultCopyWith<$Res> {
  factory $LevelResultCopyWith(
          LevelResult value, $Res Function(LevelResult) then) =
      _$LevelResultCopyWithImpl<$Res>;
  $Res call({@DateTimeConverter() DateTime time, double tension});
}

/// @nodoc
class _$LevelResultCopyWithImpl<$Res> implements $LevelResultCopyWith<$Res> {
  _$LevelResultCopyWithImpl(this._value, this._then);

  final LevelResult _value;
  // ignore: unused_field
  final $Res Function(LevelResult) _then;

  @override
  $Res call({
    Object? time = freezed,
    Object? tension = freezed,
  }) {
    return _then(_value.copyWith(
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tension: tension == freezed
          ? _value.tension
          : tension // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$LevelResultCopyWith<$Res>
    implements $LevelResultCopyWith<$Res> {
  factory _$LevelResultCopyWith(
          _LevelResult value, $Res Function(_LevelResult) then) =
      __$LevelResultCopyWithImpl<$Res>;
  @override
  $Res call({@DateTimeConverter() DateTime time, double tension});
}

/// @nodoc
class __$LevelResultCopyWithImpl<$Res> extends _$LevelResultCopyWithImpl<$Res>
    implements _$LevelResultCopyWith<$Res> {
  __$LevelResultCopyWithImpl(
      _LevelResult _value, $Res Function(_LevelResult) _then)
      : super(_value, (v) => _then(v as _LevelResult));

  @override
  _LevelResult get _value => super._value as _LevelResult;

  @override
  $Res call({
    Object? time = freezed,
    Object? tension = freezed,
  }) {
    return _then(_LevelResult(
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tension: tension == freezed
          ? _value.tension
          : tension // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LevelResult extends _LevelResult {
  _$_LevelResult(
      {@DateTimeConverter() required this.time, required this.tension})
      : super._();

  factory _$_LevelResult.fromJson(Map<String, dynamic> json) =>
      _$$_LevelResultFromJson(json);

  @override
  @DateTimeConverter()
  final DateTime time;
  @override
  final double tension;

  @override
  String toString() {
    return 'LevelResult(time: $time, tension: $tension)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LevelResult &&
            const DeepCollectionEquality().equals(other.time, time) &&
            const DeepCollectionEquality().equals(other.tension, tension));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(time),
      const DeepCollectionEquality().hash(tension));

  @JsonKey(ignore: true)
  @override
  _$LevelResultCopyWith<_LevelResult> get copyWith =>
      __$LevelResultCopyWithImpl<_LevelResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LevelResultToJson(this);
  }
}

abstract class _LevelResult extends LevelResult {
  factory _LevelResult(
      {@DateTimeConverter() required DateTime time,
      required double tension}) = _$_LevelResult;
  _LevelResult._() : super._();

  factory _LevelResult.fromJson(Map<String, dynamic> json) =
      _$_LevelResult.fromJson;

  @override
  @DateTimeConverter()
  DateTime get time;
  @override
  double get tension;
  @override
  @JsonKey(ignore: true)
  _$LevelResultCopyWith<_LevelResult> get copyWith =>
      throw _privateConstructorUsedError;
}
