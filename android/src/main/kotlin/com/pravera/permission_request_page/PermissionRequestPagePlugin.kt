package com.pravera.permission_request_page

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** PermissionRequestPagePlugin */
class PermissionRequestPagePlugin : FlutterPlugin, ActivityAware {
    private lateinit var methodCallHandler: MethodCallHandlerImpl
    private var activityBinding: ActivityPluginBinding? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodCallHandler = MethodCallHandlerImpl(binding.applicationContext)
        methodCallHandler.init(binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        if (::methodCallHandler.isInitialized) {
            methodCallHandler.dispose()
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodCallHandler.setActivity(binding.activity)
        binding.addActivityResultListener(methodCallHandler)
        activityBinding = binding
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        activityBinding?.removeActivityResultListener(methodCallHandler)
        activityBinding = null
        methodCallHandler.setActivity(null)
    }
}
