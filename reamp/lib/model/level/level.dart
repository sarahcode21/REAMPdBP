import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reamp/core/config/level.dart';
import 'package:reamp/core/config/levels.dart';
import 'package:reamp/model/result/result.dart';

part 'level.freezed.dart';
part 'level.g.dart';

const kLevelSessionsNeededForCompletion = 3;

@freezed
class Level with _$Level {
  const Level._();

  factory Level({
    required String levelConfigID,

    @Default(<LevelResult>[])
    List<LevelResult> results,

    @Default(kLevelSessionsNeededForCompletion)
    int sessionsNeededForCompletion,
  }) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);



  Map<String, dynamic> getAnonymousJson() => {
    'id': levelConfigID,
    'results': results.map((e) => e.toAnonymousJson()),
  };



  LevelConfig get config => Levels.getLevelWithID(levelConfigID);
  int get sessionsCompleted => results.length~/2;
  bool get completed => sessionsCompleted >= sessionsNeededForCompletion;


}
