import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reamp/core/config/theme.dart';
import 'package:reamp/core/style/component/buttons.dart';
import 'package:reamp/page/onboarding/assessment3.dart';
import 'package:reamp/page/onboarding/assessment4.dart';
import 'package:reamp/page/onboarding/videolandscape.dart';
import 'package:video_player/video_player.dart';

class AssetPlayerWidget extends StatefulWidget {
  String classname;
  AssetPlayerWidget({Key? key, required this.classname}) : super(key: key);

  @override
  State<AssetPlayerWidget> createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  final asset = 'assets/img/mrtKurzfilm.mp4';
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((_) => controller.pause());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return VideoPlayerWidget(
        controller: controller, classname: widget.classname);
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final classname;
  const VideoPlayerWidget(
      {Key? key, required this.controller, required this.classname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)?.settings.name);
    return controller.value.isInitialized
        ? Scaffold(
            backgroundColor: ReampColors.background,
            body: buildVideo(classname))
        : Container(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
  }

  Widget buildVideo(String classname) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(
              child: BasicOverlayWidget(
            controller: controller,
            classname: classname,
          )),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;
    return FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.center,
        child: SizedBox(width: width, height: height, child: child));
  }
}

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final String classname;

  const BasicOverlayWidget(
      {Key? key, required this.controller, required this.classname})
      : super(key: key);

  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: <Widget>[
          buildPlay(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: buildIndicator(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildfullscreenLogo(context, classname),
          ),
        ],
      ));

  Widget buildfullscreenLogo(BuildContext context, String classname) =>
      IconButton(
        iconSize: 30,
        onPressed: () {
          controller.pause();

          classname == 'assessment3'
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LandscapeVideo()))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const OnboardingAssessment3()));
        },
        icon: const Icon(
          Icons.fullscreen,
          color: Colors.grey,
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;
    return FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        child: SizedBox(width: width, height: height, child: child));
  }

  Widget buildIndicator() => VideoProgressIndicator(controller,
      allowScrubbing: true,
      colors: VideoProgressColors(
          backgroundColor: ReampColors.background,
          playedColor: ReampColors.primary,
          bufferedColor: ReampColors.backgroundBright));

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(Icons.play_arrow, color: ReampColors.primary, size: 80));
}

class IconToggleButton extends StatelessWidget {
  final bool isSelected;
  final Function onPressed;
  const IconToggleButton({required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: IconButton(
        iconSize: 30.0,
        padding: EdgeInsets.all(5),
        icon: Padding(
          padding: EdgeInsets.zero,
          child: isSelected == true
              ? const Icon(Icons.fullscreen, color: Colors.grey)
              : const Icon(Icons.fullscreen, color: Colors.grey),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
