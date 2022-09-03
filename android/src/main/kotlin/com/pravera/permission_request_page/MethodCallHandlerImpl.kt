package com.pravera.permission_request_page

import android.app.Activity
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

/** MethodCallHandlerImpl */
class MethodCallHandlerImpl(private val context: Context) : MethodChannel.MethodCallHandler,
    PluginRegistry.ActivityResultListener {

    companion object {
        const val OVERLAY_PERMISSION_SETTINGS_REQ_CODE = 100
        const val LOCATION_SERVICES_SETTINGS_REQ_CODE = 200
    }

    private lateinit var methodChannel: MethodChannel
    private var activity: Activity? = null
    private var methodCallResult1: MethodChannel.Result? = null
    private var methodCallResult2: MethodChannel.Result? = null

    fun init(messenger: BinaryMessenger) {
        methodChannel =
            MethodChannel(messenger, "flutter.pravera.com/permission_request_page/method")
        methodChannel.setMethodCallHandler(this)
    }

    fun setActivity(activity: Activity?) {
        this.activity = activity
    }

    fun dispose() {
        if (::methodChannel.isInitialized) {
            methodChannel.setMethodCallHandler(null)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method = call.method
        if (method.equals("openOverlayPermissionSettings") || method.equals("openLocationServicesSettings")) {
            if (activity == null) {
                result.error(
                    "ACTIVITY_NOT_ATTACHED",
                    "Cannot call method using Activity because Activity is not attached to FlutterEngine.",
                    null
                )
                return
            }
        }

        when (method) {
            "canDrawOverlays" -> {
                result.success(PermissionUtils.canDrawOverlays(context))
            }
            "openOverlayPermissionSettings" -> {
                methodCallResult1 = result
                PermissionUtils.openOverlayPermissionSettings(
                    activity = activity!!,
                    requestCode = OVERLAY_PERMISSION_SETTINGS_REQ_CODE
                )
            }
            "isLocationServicesEnabled" -> {
                result.success(PermissionUtils.isLocationServicesEnabled(context))
            }
            "openLocationServicesSettings" -> {
                methodCallResult2 = result
                PermissionUtils.openLocationServicesSettings(
                    activity = activity!!,
                    requestCode = LOCATION_SERVICES_SETTINGS_REQ_CODE
                )
            }
            else -> result.notImplemented()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (requestCode) {
            OVERLAY_PERMISSION_SETTINGS_REQ_CODE -> {
                val result = PermissionUtils.canDrawOverlays(context)
                methodCallResult1?.success(result)
            }
            LOCATION_SERVICES_SETTINGS_REQ_CODE -> {
                val result = PermissionUtils.isLocationServicesEnabled(context)
                methodCallResult2?.success(result)
            }
        }

        return resultCode == Activity.RESULT_OK
    }
}
