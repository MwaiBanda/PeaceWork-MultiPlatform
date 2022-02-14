package com.mwaibanda.peacework_multiplatform

import com.mwaibanda.peacework_multiplatform.utils.PlatformSocketListener

internal expect class PlatformSocket(url: String) {
    fun openSocket(listener: PlatformSocketListener)
    fun closeSocket(code: Int, reason: String)
    fun sendMessage(msg: String)
}