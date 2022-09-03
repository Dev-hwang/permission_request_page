package com.pravera.permission_request_page

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.location.LocationManager
import android.net.Uri
import android.os.Build
import android.provider.Settings

class PermissionUtils {
    companion object {
        fun canDrawOverlays(context: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return true
            return Settings.canDrawOverlays(context)
        }

        fun openOverlayPermissionSettings(activity: Activity, requestCode: Int) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M || canDrawOverlays(activity)) {
                val intent = Intent(activity.applicationContext, activity::class.java)
                activity.startActivityForResult(intent, requestCode)
                return
            }

            val packageUri = Uri.parse("package:${activity.packageName}")
            val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, packageUri)
            activity.startActivityForResult(intent, requestCode)
        }

        fun isLocationServicesEnabled(context: Context): Boolean {
            val lm = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
            return lm.isProviderEnabled(LocationManager.GPS_PROVIDER)
        }

        fun openLocationServicesSettings(activity: Activity, requestCode: Int) {
            val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            intent.addCategory(Intent.CATEGORY_DEFAULT)
            activity.startActivityForResult(intent, requestCode)
        }
    }
}
