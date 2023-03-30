enum LevelOrientation {
  vertical, horizontal
}

class LevelConfig {
  final String id;

  final String name;
  final String description;
  final String assessmentDescription;
  final int estimatedDuration;

  final String videoAssetPath;
  final String previewAssetPath;
  final bool skippable;
  final Duration minimumWatchTime;
  final LevelOrientation orientation;

  const LevelConfig({
    required this.id,
    required this.name,
    required this.description,
    required this.assessmentDescription,
    required this.videoAssetPath,
    required this.previewAssetPath,
    required this.estimatedDuration,
    this.skippable = true,
    this.orientation = LevelOrientation.vertical,
    this.minimumWatchTime = const Duration(seconds: 90),
  });
}
