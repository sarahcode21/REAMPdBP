import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reamp/core/config/level.dart';
import 'package:reamp/model/level/level.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
class StateData with _$StateData {
  const StateData._();

  factory StateData({
    double? baseAnxiety,
    DateTime? mrtDate,
    @Default(false) bool onboardingFinished,
    @Default(<String, double>{}) Map<String, double> assessmentResults,
    @Default(<String, bool>{}) Map<String, bool> checkboxesVorab,
    @Default(<String, bool>{}) Map<String, bool> checkboxesMrtTag,
    @Default(<String, bool>{}) Map<String, bool> levelscompleted,
    @Default(<String>[]) List<String> therapieElemente,
    @Default(<Level>[]) List<Level> levels,
    @Default(false) bool presentationMode,
  }) = _StateData;

  factory StateData.fromJson(Map<String, dynamic> json) =>
      _$StateDataFromJson(json);

  Map<String, dynamic> getAnonymousJson() => {
        'baseAnxiety': baseAnxiety,
        'levels': levels.map((e) => e.getAnonymousJson()),
        'assessmentResults': assessmentResults
      };

  double getOverallAnxietyLevel() {
    if (baseAnxiety != null) {
      return assessmentResults.values
          .fold(baseAnxiety!, (sum, value) => sum + value);
    } else {
      return 0;
    }
  }

  Level getLevelDataForConfig(LevelConfig config) => levels.firstWhere(
        (element) => element.config == config,
        orElse: () => Level(levelConfigID: config.id),
      );
}
