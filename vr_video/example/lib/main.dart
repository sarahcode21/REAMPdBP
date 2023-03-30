import 'package:flutter/material.dart';

import 'package:vr_video/vr_video.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('vr_video Plugin example app'),
        ),
        body: Center(
          child: MaterialButton(
            child: Text('Start'),
            onPressed: () => VrVideo.startVideo(asset: 'assets/test.mp4'),
          ),
        ),
      ),
    );
  }
}
