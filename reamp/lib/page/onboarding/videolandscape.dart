import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:reamp/page/onboarding/videoplayer.dart';

class LandscapeVideo extends StatefulWidget {
  const LandscapeVideo({Key? key}) : super(key: key);

  @override
  State<LandscapeVideo> createState() => _LandscapeVideoState();
}

class _LandscapeVideoState extends State<LandscapeVideo> {
  @override
  void initState() {
    setLandscape();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future setLandscape() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return AssetPlayerWidget(classname: 'landscapevideo');
  }
}
