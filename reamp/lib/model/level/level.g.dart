// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Level _$$_LevelFromJson(Map<String, dynamic> json) => _$_Level(
      levelConfigID: json['levelConfigID'] as String,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => LevelResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LevelResult>[],
      sessionsNeededForCompletion:
          json['sessionsNeededForCompletion'] as int? ??
              kLevelSessionsNeededForCompletion,
    );

Map<String, dynamic> _$$_LevelToJson(_$_Level instance) => <String, dynamic>{
      'levelConfigID': instance.levelConfigID,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'sessionsNeededForCompletion': instance.sessionsNeededForCompletion,
    };
