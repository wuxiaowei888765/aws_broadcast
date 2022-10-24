package com.cn.aws.broadcast.aws_broadcast

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import com.amazonaws.ivs.broadcast.BroadcastException
import com.amazonaws.ivs.broadcast.BroadcastSession
import com.amazonaws.ivs.broadcast.Presets
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** AwsBroadcastPlugin */
class AwsBroadcastPlugin : FlutterPlugin, MethodCallHandler,
    BroadcastSession.Listener()
{
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private  lateinit var broadcastSession: BroadcastSession

    private lateinit var context:Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "aws_broadcast")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                println("getPlatformVersion")
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getPermission" -> {
                println("getPermission")
                getPermission(call,result)
                result.success(0)
            }
            "initBroadcast" -> {
                initializeRecorder(call,result)
                result.success(0)
            }
            "startBroadcast" -> {
                startBroadcast(call,result)
                result.success(0)
            }
            "stopBroadcast" -> {
                stopBroadcast()
                result.success(0)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * 获取权限
     */
    private fun getPermission(@NonNull call: MethodCall, @NonNull result: Result) {
        val requiredPermissions =
            arrayOf<String>(Manifest.permission.CAMERA, Manifest.permission.RECORD_AUDIO)

        for (permission in requiredPermissions) {
            if (ContextCompat.checkSelfPermission(context, permission)
                != PackageManager.PERMISSION_GRANTED
            ) {
                // If any permissions are missing we want to just request them all.
//                ActivityCompat.requestPermissions(context, requiredPermissions, 0x100)
                break
            }
        }
    }

    /**
     * 停止直播
     */
    private fun stopBroadcast() {
        broadcastSession.stop()
        broadcastSession.release()
    }

    /**
     * 开始直播
     */
    private fun startBroadcast(@NonNull call: MethodCall, @NonNull result: Result) {
        broadcastSession.start(call.argument("IVS_RTMPS_URL"), call.argument("IVS_STREAMKEY"))
    }

    /**
     * 初始化广播
     */
    private fun initializeRecorder(@NonNull call: MethodCall, @NonNull result: Result) {
        broadcastSession = BroadcastSession(
            context,
            this,
            Presets.Configuration.STANDARD_PORTRAIT,
            Presets.Devices.FRONT_CAMERA(context)
        )
        result.success(1)
    }

    /**
     * 广播监听
     */
    override fun onStateChanged(p0: BroadcastSession.State) {

    }

    override fun onError(p0: BroadcastException) {

    }
}
