package io.ccn.vr_video

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Intent
import android.content.Context

/** VrVideoPlugin */
class VrVideoPlugin: FlutterPlugin, MethodCallHandler {
  private var binding: FlutterPlugin.FlutterPluginBinding?;

  constructor() {
    this.binding = null
  }

  constructor(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.binding = flutterPluginBinding;
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vr_video")
    channel.setMethodCallHandler(VrVideoPlugin(flutterPluginBinding))
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "startVideo") {
      val asset = call.argument("asset") as String?;
      val assetFile = binding?.flutterAssets?.getAssetFilePathByName(asset!!);
      val intent = Intent(binding?.applicationContext, VrActivity::class.java)
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      intent.putExtra("asset", assetFile)
      binding?.applicationContext?.startActivity(intent)
      result.success("")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
