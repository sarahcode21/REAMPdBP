import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class VrVideo {
  static const MethodChannel _channel = const MethodChannel('vr_video');

  /// Start a seperate view containing a 360° video player that plays the provided [asset].
  /// 
  /// The video will be repeated [loops] times, or (by default) indefinitely if [loops] is a negative number.
  /// 
  /// Before starting the video, a [countdown] in seconds can be optionally displayed.
  static Future<void> startVideo({
    required String asset,
    int loops = -1,
    int countdown = 0,
  }) async {
    if (Platform.isIOS || Platform.isAndroid) {
      await _channel.invokeMethod('startVideo', {
        'asset': asset,
        'loops': loops,
        'countdown': countdown,
      });
    } else {
      throw Exception('vr_video is not available on the current platform');
    }
  }
}
