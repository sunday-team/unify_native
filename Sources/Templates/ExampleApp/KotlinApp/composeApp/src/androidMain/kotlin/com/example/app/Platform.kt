package com.example.app

import android.os.Build

class AndroidPlatform {
    val name: String = "Android ${Build.VERSION.RELEASE} API ${Build.VERSION.SDK_INT}"
}

fun getPlatform() = AndroidPlatform()