// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StateData _$StateDataFromJson(Map<String, dynamic> json) {
  return _StateData.fromJson(json);
}

/// @nodoc
class _$StateDataTearOff {
  const _$StateDataTearOff();

  _StateData call(
      {double? baseAnxiety,
      DateTime? mrtDate,
      bool onboardingFinished = false,
      Map<String, double> assessmentResults = const <String, double>{},
      Map<String, bool> checkboxesVorab = const <String, bool>{},
      Map<String, bool> checkboxesMrtTag = const <String, bool>{},
      Map<String, bool> levelscompleted = const <String, bool>{},
      List<String> therapieElemente = const <String>[],
      List<Level> levels = const <Level>[],
      bool presentationMode = false}) {
    return _StateData(
      baseAnxiety: baseAnxiety,
      mrtDate: mrtDate,
      onboardingFinished: onboardingFinished,
      assessmentResults: assessmentResults,
      checkboxesVorab: checkboxesVorab,
      checkboxesMrtTag: checkboxesMrtTag,
      levelscompleted: levelscompleted,
      therapieElemente: therapieElemente,
      levels: levels,
      presentationMode: presentationMode,
    );
  }

  StateData fromJson(Map<String, Object?> json) {
    return StateData.fromJson(json);
  }
}

/// @nodoc
const $StateData = _$StateDataTearOff();

/// @nodoc
mixin _$StateData {
  double? get baseAnxiety => throw _privateConstructorUsedError;
  DateTime? get mrtDate => throw _privateConstructorUsedError;
  bool get onboardingFinished => throw _privateConstructorUsedError;
  Map<String, double> get assessmentResults =>
      throw _privateConstructorUsedError;
  Map<String, bool> get checkboxesVorab => throw _privateConstructorUsedError;
  Map<String, bool> get checkboxesMrtTag => throw _privateConstructorUsedError;
  Map<String, bool> get levelscompleted => throw _privateConstructorUsedError;
  List<String> get therapieElemente => throw _privateConstructorUsedError;
  List<Level> get levels => throw _privateConstructorUsedError;
  bool get presentationMode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StateDataCopyWith<StateData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateDataCopyWith<$Res> {
  factory $StateDataCopyWith(StateData value, $Res Function(StateData) then) =
      _$StateDataCopyWithImpl<$Res>;
  $Res call(
      {double? baseAnxiety,
      DateTime? mrtDate,
      bool onboardingFinished,
      Map<String, double> assessmentResults,
      Map<String, bool> checkboxesVorab,
      Map<String, bool> checkboxesMrtTag,
      Map<String, bool> levelscompleted,
      List<String> therapieElemente,
      List<Level> levels,
      bool presentationMode});
}

/// @nodoc
class _$StateDataCopyWithImpl<$Res> implements $StateDataCopyWith<$Res> {
  _$StateDataCopyWithImpl(this._value, this._then);

  final StateData _value;
  // ignore: unused_field
  final $Res Function(StateData) _then;

  @override
  $Res call({
    Object? baseAnxiety = freezed,
    Object? mrtDate = freezed,
    Object? onboardingFinished = freezed,
    Object? assessmentResults = freezed,
    Object? checkboxesVorab = freezed,
    Object? checkboxesMrtTag = freezed,
    Object? levelscompleted = freezed,
    Object? therapieElemente = freezed,
    Object? levels = freezed,
    Object? presentationMode = freezed,
  }) {
    return _then(_value.copyWith(
      baseAnxiety: baseAnxiety == freezed
          ? _value.baseAnxiety
          : baseAnxiety // ignore: cast_nullable_to_non_nullable
              as double?,
      mrtDate: mrtDate == freezed
          ? _value.mrtDate
          : mrtDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      onboardingFinished: onboardingFinished == freezed
          ? _value.onboardingFinished
          : onboardingFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      assessmentResults: assessmentResults == freezed
          ? _value.assessmentResults
          : assessmentResults // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      checkboxesVorab: checkboxesVorab == freezed
          ? _value.checkboxesVorab
          : checkboxesVorab // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      checkboxesMrtTag: checkboxesMrtTag == freezed
          ? _value.checkboxesMrtTag
          : checkboxesMrtTag // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      levelscompleted: levelscompleted == freezed
          ? _value.levelscompleted
          : levelscompleted // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      therapieElemente: therapieElemente == freezed
          ? _value.therapieElemente
          : therapieElemente // ignore: cast_nullable_to_non_nullable
              as List<String>,
      levels: levels == freezed
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<Level>,
      presentationMode: presentationMode == freezed
          ? _value.presentationMode
          : presentationMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$StateDataCopyWith<$Res> implements $StateDataCopyWith<$Res> {
  factory _$StateDataCopyWith(
          _StateData value, $Res Function(_StateData) then) =
      __$StateDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {double? baseAnxiety,
      DateTime? mrtDate,
      bool onboardingFinished,
      Map<String, double> assessmentResults,
      Map<String, bool> checkboxesVorab,
      Map<String, bool> checkboxesMrtTag,
      Map<String, bool> levelscompleted,
      List<String> therapieElemente,
      List<Level> levels,
      bool presentationMode});
}

/// @nodoc
class __$StateDataCopyWithImpl<$Res> extends _$StateDataCopyWithImpl<$Res>
    implements _$StateDataCopyWith<$Res> {
  __$StateDataCopyWithImpl(_StateData _value, $Res Function(_StateData) _then)
      : super(_value, (v) => _then(v as _StateData));

  @override
  _StateData get _value => super._value as _StateData;

  @override
  $Res call({
    Object? baseAnxiety = freezed,
    Object? mrtDate = freezed,
    Object? onboardingFinished = freezed,
    Object? assessmentResults = freezed,
    Object? checkboxesVorab = freezed,
    Object? checkboxesMrtTag = freezed,
    Object? levelscompleted = freezed,
    Object? therapieElemente = freezed,
    Object? levels = freezed,
    Object? presentationMode = freezed,
  }) {
    return _then(_StateData(
      baseAnxiety: baseAnxiety == freezed
          ? _value.baseAnxiety
          : baseAnxiety // ignore: cast_nullable_to_non_nullable
              as double?,
      mrtDate: mrtDate == freezed
          ? _value.mrtDate
          : mrtDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      onboardingFinished: onboardingFinished == freezed
          ? _value.onboardingFinished
          : onboardingFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      assessmentResults: assessmentResults == freezed
          ? _value.assessmentResults
          : assessmentResults // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      checkboxesVorab: checkboxesVorab == freezed
          ? _value.checkboxesVorab
          : checkboxesVorab // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      checkboxesMrtTag: checkboxesMrtTag == freezed
          ? _value.checkboxesMrtTag
          : checkboxesMrtTag // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      levelscompleted: levelscompleted == freezed
          ? _value.levelscompleted
          : levelscompleted // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      therapieElemente: therapieElemente == freezed
          ? _value.therapieElemente
          : therapieElemente // ignore: cast_nullable_to_non_nullable
              as List<String>,
      levels: levels == freezed
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<Level>,
      presentationMode: presentationMode == freezed
          ? _value.presentationMode
          : presentationMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StateData extends _StateData {
  _$_StateData(
      {this.baseAnxiety,
      this.mrtDate,
      this.onboardingFinished = false,
      this.assessmentResults = const <String, double>{},
      this.checkboxesVorab = const <String, bool>{},
      this.checkboxesMrtTag = const <String, bool>{},
      this.levelscompleted = const <String, bool>{},
      this.therapieElemente = const <String>[],
      this.levels = const <Level>[],
      this.presentationMode = false})
      : super._();

  factory _$_StateData.fromJson(Map<String, dynamic> json) =>
      _$$_StateDataFromJson(json);

  @override
  final double? baseAnxiety;
  @override
  final DateTime? mrtDate;
  @JsonKey()
  @override
  final bool onboardingFinished;
  @JsonKey()
  @override
  final Map<String, double> assessmentResults;
  @JsonKey()
  @override
  final Map<String, bool> checkboxesVorab;
  @JsonKey()
  @override
  final Map<String, bool> checkboxesMrtTag;
  @JsonKey()
  @override
  final Map<String, bool> levelscompleted;
  @JsonKey()
  @override
  final List<String> therapieElemente;
  @JsonKey()
  @override
  final List<Level> levels;
  @JsonKey()
  @override
  final bool presentationMode;

  @override
  String toString() {
    return 'StateData(baseAnxiety: $baseAnxiety, mrtDate: $mrtDate, onboardingFinished: $onboardingFinished, assessmentResults: $assessmentResults, checkboxesVorab: $checkboxesVorab, checkboxesMrtTag: $checkboxesMrtTag, levelscompleted: $levelscompleted, therapieElemente: $therapieElemente, levels: $levels, presentationMode: $presentationMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StateData &&
            const DeepCollectionEquality()
                .equals(other.baseAnxiety, baseAnxiety) &&
            const DeepCollectionEquality().equals(other.mrtDate, mrtDate) &&
            const DeepCollectionEquality()
                .equals(other.onboardingFinished, onboardingFinished) &&
            const DeepCollectionEquality()
                .equals(other.assessmentResults, assessmentResults) &&
            const DeepCollectionEquality()
                .equals(other.checkboxesVorab, checkboxesVorab) &&
            const DeepCollectionEquality()
                .equals(other.checkboxesMrtTag, checkboxesMrtTag) &&
            const DeepCollectionEquality()
                .equals(other.levelscompleted, levelscompleted) &&
            const DeepCollectionEquality()
                .equals(other.therapieElemente, therapieElemente) &&
            const DeepCollectionEquality().equals(other.levels, levels) &&
            const DeepCollectionEquality()
                .equals(other.presentationMode, presentationMode));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(baseAnxiety),
      const DeepCollectionEquality().hash(mrtDate),
      const DeepCollectionEquality().hash(onboardingFinished),
      const DeepCollectionEquality().hash(assessmentResults),
      const DeepCollectionEquality().hash(checkboxesVorab),
      const DeepCollectionEquality().hash(checkboxesMrtTag),
      const DeepCollectionEquality().hash(levelscompleted),
      const DeepCollectionEquality().hash(therapieElemente),
      const DeepCollectionEquality().hash(levels),
      const DeepCollectionEquality().hash(presentationMode));

  @JsonKey(ignore: true)
  @override
  _$StateDataCopyWith<_StateData> get copyWith =>
      __$StateDataCopyWithImpl<_StateData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StateDataToJson(this);
  }
}

abstract class _StateData extends StateData {
  factory _StateData(
      {double? baseAnxiety,
      DateTime? mrtDate,
      bool onboardingFinished,
      Map<String, double> assessmentResults,
      Map<String, bool> checkboxesVorab,
      Map<String, bool> checkboxesMrtTag,
      Map<String, bool> levelscompleted,
      List<String> therapieElemente,
      List<Level> levels,
      bool presentationMode}) = _$_StateData;
  _StateData._() : super._();

  factory _StateData.fromJson(Map<String, dynamic> json) =
      _$_StateData.fromJson;

  @override
  double? get baseAnxiety;
  @override
  DateTime? get mrtDate;
  @override
  bool get onboardingFinished;
  @override
  Map<String, double> get assessmentResults;
  @override
  Map<String, bool> get checkboxesVorab;
  @override
  Map<String, bool> get checkboxesMrtTag;
  @override
  Map<String, bool> get levelscompleted;
  @override
  List<String> get therapieElemente;
  @override
  List<Level> get levels;
  @override
  bool get presentationMode;
  @override
  @JsonKey(ignore: true)
  _$StateDataCopyWith<_StateData> get copyWith =>
      throw _privateConstructorUsedError;
}
