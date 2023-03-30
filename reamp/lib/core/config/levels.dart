import 'package:reamp/core/config/level.dart';

class Levels {
  static const List<LevelConfig> levels = [
    LevelConfig(
      id: "waiting_room",
      name: "Warteraum",
      description: "Bereiten Sie sich langsam auf die Untersuchung vor und nehmen Sie zunächst im Wartezimmer Platz.",
      assessmentDescription: "Wie hoch schätzt du deine Angst ein wenn du an den Warteraum denkst?",
      videoAssetPath: "videos/waiting_room.mp4",
      previewAssetPath: "assets/img/preview_waiting.jpg",
      estimatedDuration: 5,
    ),
    LevelConfig(
      id: "examination_room",
      name: "Untersuchungsraum",
      description: "Werfen Sie einen ersten Blick aus der Distanz auf das MRT Gerät.",
      assessmentDescription: "Wie hoch schätzt du deine Angst ein wenn du an den Untersuchungsraum denkst?",
      videoAssetPath: "videos/MRT_room.mp4",
      previewAssetPath: "assets/img/preview_mrt_room_near.jpg",
      estimatedDuration: 5,
    ),
    LevelConfig(
      id: "mrt_near",
      name: "Vor dem MRT-Gerät",
      description: "Betrachten Sie das MRT-Gerät aus der Nähe.",
      assessmentDescription: "Wie hoch schätzt du deine Angst ein wenn du an die Untersuchung denkst?",
      videoAssetPath: "videos/MRT_room_near.mp4",
      previewAssetPath: "assets/img/preview_mrt_room_near.jpg",
      estimatedDuration: 5,
    ),
    LevelConfig(
      id: "mrt_examination",
      name: "Untersuchung",
      description: "Durchführung der MRT-Untersuchung in der Röhre.",
      assessmentDescription: "Wie hoch schätzt du deine Angst ein wenn du an die Untersuchung denkst?",
      videoAssetPath: "videos/MRT.mp4",
      previewAssetPath: "assets/img/preview_mrt.jpg",
      estimatedDuration: 14,
      skippable: false,
      minimumWatchTime: Duration(minutes: 3),
      orientation: LevelOrientation.horizontal,
    ),
  ];

  static getLevelWithID(String id) {
    return levels.firstWhere(
      (ele) => ele.id == id,
      orElse: () => LevelConfig(
        id: id,
        name: "Error",
        description: "Unknown Level with id: $id",
        assessmentDescription: "",
        estimatedDuration: 0,
        videoAssetPath: '',
        previewAssetPath: '',
      ),
    );
  }
}
