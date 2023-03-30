import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:reamp/bloc/state.dart';
import 'package:reamp/core/config/levels.dart';
import 'package:reamp/core/config/level.dart';
import 'package:reamp/core/style/style.dart';
import 'package:reamp/model/model.dart';
import 'package:vr_video/vr_video.dart';

class VideoInfo extends StatefulWidget {
  final Level level;

  const VideoInfo({ required this.level, Key? key }) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  bool before = true;
  

  // TODO Move into bloc?
  Future<void> watchVideo(ReampStateLoaded state) async {
    final startTime = DateTime.now();
    await VrVideo.startVideo(
      asset: widget.level.config.videoAssetPath,
      loops: 0,
    );
    final duration = DateTime.now().difference(startTime).inSeconds;
  
    final int requiredSeconds;
    if(state.data.presentationMode){
      requiredSeconds = 0;
    } else{
      requiredSeconds = widget.level.config.minimumWatchTime.inSeconds;
    }

    if (duration < requiredSeconds) {
      setState(() => before = false);
    } else {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReampStateBloc>().state as ReampStateLoaded;

    return GeneralLayout(
      showBackButton: before,
      title: widget.level.config.name,
      padding: false,
      child: before 
        ? _BeforeVideo(
            startVideo: () => watchVideo(state),
            skippable: widget.level.sessionsCompleted != 0 || widget.level.config.id != Levels.levels[0].id,
            orientation: widget.level.config.orientation,
          )
        : const _AfterVideo(),
    );
  }
}

class _VRTileData {
  final String text;
  final String imgPath;

  const _VRTileData({required this.text, required this.imgPath});
}

class _BeforeVideo extends StatefulWidget {
  final Function() startVideo;
  final bool skippable;
  final LevelOrientation orientation;

  const _BeforeVideo({ required this.startVideo, required this.skippable, required this.orientation, Key? key }) : super(key: key);

  @override
  State<_BeforeVideo> createState() => _BeforeVideoState();
}

class _BeforeVideoState extends State<_BeforeVideo> {
  final _data = <_VRTileData>[
    const _VRTileData(
      text: "1. Verbinde dein Smartphone mit deinen Kopfhörern.",
      imgPath: "assets/img/vr_1.png",
    ),
    const _VRTileData(
      text: "2. Starte die Sitzung in der REAMP App.",
      imgPath: "assets/img/vr_2.png",
    ),
    const _VRTileData(
      text: "3. Lege dein Smartphone in die VR-Brille ein. Dazu legst du dein Smartphone vorne in die VR-Brille mit dem Bildschirm in Richtung Linse.",
      imgPath: "assets/img/vr_3.png",
    ),
    const _VRTileData(
      text: "4. Setze die Brille auf und stelle die Gummibänder so ein, dass die Brille angenehm sitzt.",
      imgPath: "assets/img/vr_4.png",
    ),
    const _VRTileData(
      text: "5. Drehe an dem Rädchen oben auf der VR-Brille, bis du das Bild auf dem Bildschirm scharf siehst.",
      imgPath: "assets/img/vr_5.png",
    ),
    const _VRTileData(
      text: "6. Mithilfe des Schiebereglers auf der Unterseite der Brille kannst du den Abstand der Linsen einstellen. Schiebe den Regler so weit nach vorne, bis du das Bild scharf siehst.",
      imgPath: "assets/img/vr_6.png",
    ),
    const _VRTileData(
      text: "7. Ziehe deine Kopfhörer auf und du bist startbereit.",
      imgPath: "assets/img/vr_7.png",
    ),
  ];

  bool enabled = false;

  @override
  void initState() {
    super.initState();
    _data.insert(0, _VRTileData(
      text: "Diese Sitzung solltest du im ${widget.orientation == LevelOrientation.horizontal ? "liegen" : "sitzen"} durchführen. Bitte lies dir zuerst die Anleitung durch und starte dann das Video.",
      imgPath: "assets/img/vr_0.png",
    ));
    enabled = _data.length == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Nutzung der VR-Brille",
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        ContentBoxPageView(
          height: 350,
          onPageChanged: (page) => setState(() => enabled = (page+1) == _data.length),
          pages: [
            for (final data in _data) Column(
              children: [
                SizedBox(
                  height: 150,
                  child: Image.asset(
                    data.imgPath,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(child: Container()),
                Text(data.text),
              ],
            ),
          ],
        ),
        PrimaryButton(
          onPressed: enabled || widget.skippable ? widget.startVideo : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.play_arrow),
              SizedBox(width: 12.0),
              Text("Video starten"),
            ],
          ),
        ),
      ],
    );
  }
}

class _AfterVideo extends StatelessWidget {
  const _AfterVideo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentBox(
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            "Du hast diese Sitzung sehr schnell wieder abgebrochen. Wir empfehlen dir, die Sitzung zu wiederholen. Starte die Sitzung erneut oder mache gerne eine Pause und wiederhole die Sitzung zu einem späteren Zeitpunkt.",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const SizedBox(height: 32.0),
        PrimaryButton(
          onPressed: () => Navigator.pop(context),
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: const Text("Jetzt wiederholen"),
        ),
        PrimaryButton(
          onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: const Text("Später wiederholen"),
        ),
      ],
    );
  }
}
