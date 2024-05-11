package com.syedmoizali.internet_speed_meter

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.net.TrafficStats
import android.net.ConnectivityManager
import android.os.Build
import kotlin.concurrent.fixedRateTimer

/** InternetSpeedMeterPlugin */
class InternetSpeedMeterPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context // Store the context for later use
    private var lastRxBytes = 0L
    private var lastTxBytes = 0L
    private var lastUpdateTime = System.currentTimeMillis()
    private var rxSpeedList = mutableListOf<Double>()
    private var txSpeedList = mutableListOf<Double>()
    private val NUM_SAMPLES = 5 // Number of samples to average

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "internet_speed_meter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "getSpeed") {
            val speed = getNetworkSpeed()
            result.success(speed)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getNetworkSpeed(): Double {
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        if (activeNetworkInfo != null && activeNetworkInfo.isConnected) {
            val rxBytes = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                TrafficStats.getTotalRxBytes()
            } else {
                TrafficStats.getTotalRxBytes() + TrafficStats.getTotalRxPackets()
            }
            val txBytes = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                TrafficStats.getTotalTxBytes()
            } else {
                TrafficStats.getTotalTxBytes() + TrafficStats.getTotalTxPackets()
            }
            val currentTime = System.currentTimeMillis()
            val elapsedTime = currentTime - lastUpdateTime
            val rxSpeed = ((rxBytes - lastRxBytes) * 1000.0) / elapsedTime // Bytes per second
            val txSpeed = ((txBytes - lastTxBytes) * 1000.0) / elapsedTime // Bytes per second
            lastRxBytes = rxBytes
            lastTxBytes = txBytes
            lastUpdateTime = currentTime

            rxSpeedList.add(rxSpeed)
            txSpeedList.add(txSpeed)

            // Keep only the last NUM_SAMPLES samples
            if (rxSpeedList.size > NUM_SAMPLES) {
                rxSpeedList.removeAt(0)
                txSpeedList.removeAt(0)
            }

            // Calculate average speed
            val avgRxSpeed = rxSpeedList.average()
            val avgTxSpeed = txSpeedList.average()

            return avgRxSpeed + avgTxSpeed // Combined network speed
        } else {
            return 0.0
        }
    }
}
