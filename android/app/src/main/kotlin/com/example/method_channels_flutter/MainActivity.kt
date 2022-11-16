package com.example.method_channels_flutter

import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "test.flutter"
    private lateinit var handler: Handler
    private lateinit var flutterChannel: MethodChannel
    
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        handler = Handler(Looper.getMainLooper())
        val messenger: BinaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        flutterChannel = MethodChannel(messenger, CHANNEL)

        flutterChannel.setMethodCallHandler { call, result ->

            // taking parameter from flutter
            val param1:Int? = call.argument<Int>("param1")

            if (call.method == "getMessage") {
              result.success("Received callback from android $param1")
               // result.error("-1", "something went wrong", "something went wrong")
            }

            handler.postDelayed({
                flutterChannel.invokeMethod("fromNative", "{\"message\":\"Hello from native android\"}");
            }, 3000)

        }
    }
}
