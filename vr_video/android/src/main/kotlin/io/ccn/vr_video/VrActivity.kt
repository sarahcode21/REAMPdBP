package io.ccn.vr_video

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.view.LayoutInflater
import android.view.View
import com.google.vr.sdk.widgets.video.VrVideoEventListener
import com.google.vr.sdk.widgets.video.VrVideoView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class VrActivity : Activity() {
    lateinit var videoView: VrVideoView

    override fun onPause() {
        super.onPause();
        videoView.pauseRendering();
    }

    override fun onResume() {
        super.onResume();
        videoView.resumeRendering();
    }

    override fun onDestroy() {
        videoView.pauseRendering()
        videoView.shutdown()
        super.onDestroy()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_vr)

        val asset = getIntent().getExtras()?.getString("asset")

        videoView = findViewById(R.id.video_view) as VrVideoView
        videoView.setDisplayMode(3)
        videoView.loadVideoFromAsset(asset, VrVideoView.Options())
        videoView.setEventListener(object: VrVideoEventListener() {
            override fun onCompletion() {
                super.onCompletion()
                videoView.seekTo(0L)
            }

            override fun onDisplayModeChanged(newDisplayMode: Int) {
                if (newDisplayMode != 3 && newDisplayMode != 2) {
                    finish()
                }
            }
        })
    }
}
