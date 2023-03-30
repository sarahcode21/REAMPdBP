// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StateData _$$_StateDataFromJson(Map<String, dynamic> json) => _$_StateData(
      baseAnxiety: (json['baseAnxiety'] as num?)?.toDouble(),
      mrtDate: json['mrtDate'] == null
          ? null
          : DateTime.parse(json['mrtDate'] as String),
      onboardingFinished: json['onboardingFinished'] as bool? ?? false,
      assessmentResults:
          (json['assessmentResults'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const <String, double>{},
      checkboxesVorab: (json['checkboxesVorab'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const <String, bool>{},
      checkboxesMrtTag:
          (json['checkboxesMrtTag'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as bool),
              ) ??
              const <String, bool>{},
      levelscompleted: (json['levelscompleted'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const <String, bool>{},
      therapieElemente: (json['therapieElemente'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      levels: (json['levels'] as List<dynamic>?)
              ?.map((e) => Level.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Level>[],
      presentationMode: json['presentationMode'] as bool? ?? false,
    );

Map<String, dynamic> _$$_StateDataToJson(_$_StateData instance) =>
    <String, dynamic>{
      'baseAnxiety': instance.baseAnxiety,
      'mrtDate': instance.mrtDate?.toIso8601String(),
      'onboardingFinished': instance.onboardingFinished,
      'assessmentResults': instance.assessmentResults,
      'checkboxesVorab': instance.checkboxesVorab,
      'checkboxesMrtTag': instance.checkboxesMrtTag,
      'levelscompleted': instance.levelscompleted,
      'therapieElemente': instance.therapieElemente,
      'levels': instance.levels.map((e) => e.toJson()).toList(),
      'presentationMode': instance.presentationMode,
    };
