import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reamp/core/util/datetime.converter.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class LevelResult with _$LevelResult {
  const LevelResult._();

  factory LevelResult({
    @DateTimeConverter() required DateTime time,
    required double tension,
  }) = _LevelResult;

  factory LevelResult.fromJson(Map<String, dynamic> json) => _$LevelResultFromJson(json);

  Map<String, dynamic> toAnonymousJson() => {
    'tension': tension,
  };
}
