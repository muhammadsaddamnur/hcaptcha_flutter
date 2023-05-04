package com.example.hcaptcha_flutter

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.hcaptcha.sdk.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.os.Build
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel


/** HcaptchaFlutterPlugin */
class HcaptchaFlutterPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var methodChannel : MethodChannel
  private lateinit var eventChannel: EventChannel
  private val SITEKEY = "501fcc46-91a9-4a9a-9504-4587079c1015"
  private var hCaptcha: HCaptcha? = null
  private lateinit var context: Context
  private lateinit var activity: Activity


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> result.success("Android ${Build.VERSION.RELEASE}")
      "onClickSetup" -> onClickSetup()
      "onClickVerify" -> onClickVerify()
      "onClickReset" -> onClickReset()
      else -> result.notImplemented()
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "hcaptcha_flutter")
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "hcaptcha_flutter")

    methodChannel.setMethodCallHandler(this)
    eventChannel.setStreamHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
  }

  private fun getConfig(): HCaptchaConfig {
    println("getConfig")
    return HCaptchaConfig.builder()
      .siteKey(SITEKEY)
      .size(HCaptchaSize.NORMAL)
      .loading(true)
      .hideDialog(false)
      .tokenExpiration(10)
      .diagnosticLog(true)
      .retryPredicate { config: HCaptchaConfig?, exception: HCaptchaException -> exception.hCaptchaError == HCaptchaError.SESSION_TIMEOUT }
      .build()
  }

  fun onClickSetup() {
    println("onClickSetup")
    hCaptcha = HCaptcha.getClient(activity).setup(getConfig())
    setupClient(hCaptcha!!)
  }

  fun onClickVerify() {
    println("onClickVerify")
    if (hCaptcha != null) {
      println("verifyWithHCaptcha")
      hCaptcha!!.verifyWithHCaptcha()
    } else {
      println("setup")
      hCaptcha = HCaptcha.getClient(activity).verifyWithHCaptcha(getConfig())
      setupClient(hCaptcha!!)
    }
  }

  private fun setupClient(hCaptcha: HCaptcha) {
    println("setupClient")
    hCaptcha
      .addOnSuccessListener { response: HCaptchaTokenResponse ->
        val userResponseToken = response.tokenResult
        println("hCaptcha success: $userResponseToken")
      }
      .addOnFailureListener { e: HCaptchaException ->
        println("hCaptcha failed: " + e.message + "(" + e.statusCode + ")")
      }
      .addOnOpenListener {
        println("hCaptcha shown")
      }
  }
  fun onClickReset() {
    println("onClickReset")
    if (hCaptcha != null) {
      hCaptcha!!.reset()
    }
    hCaptcha = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}
