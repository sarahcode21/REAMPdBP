// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LevelResult _$$_LevelResultFromJson(Map<String, dynamic> json) =>
    _$_LevelResult(
      time: const DateTimeConverter().fromJson(json['time'] as String),
      tension: (json['tension'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LevelResultToJson(_$_LevelResult instance) =>
    <String, dynamic>{
      'time': const DateTimeConverter().toJson(instance.time),
      'tension': instance.tension,
    };
