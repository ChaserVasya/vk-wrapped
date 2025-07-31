package dev.vchaser.vk_wrapped

import io.flutter.Log
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterFragmentActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        try {
            flutterEngine.plugins.add(VkidFlutterSdkUtilsPlugin())
        } catch (e: Exception) {
            Log.e("MainActivity", "Error registering plugin utils", e)
        }
    }
}
