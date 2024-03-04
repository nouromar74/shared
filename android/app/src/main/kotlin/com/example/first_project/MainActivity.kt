package com.example.first_project

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "rooted_device_checker"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isDeviceRooted" -> {
                    val isRooted = checkRootStatus()
                    result.success(isRooted)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun checkRootStatus(): Boolean {
        return Build.TAGS?.contains("test-keys") == true
    }
}
