package com.ysnzp.flutterexample

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.pm.Signature
import android.os.Bundle
import android.util.Base64
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

class MainActivity: FlutterActivity() {

  val LOG_TAG = "KakaoTalkLogin"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    Log.e("MainActivityStart", "asdasdasdasd")
    GeneratedPluginRegistrant.registerWith(this)

    val hashKey = getKeyHash(this)
    if (hashKey != null){

      Log.e(LOG_TAG, "signature=$hashKey")
    }else{
      Log.e(LOG_TAG, "hash null")
    }
  }

  fun getKeyHash(context: Context): String? {
    try {
      val pm: PackageManager = context.packageManager
      val info: PackageInfo? = pm.getPackageInfo(context.packageName, PackageManager.GET_SIGNATURES)
      if (info == null){
        return null
      }

      for (signature: Signature in info.signatures){
        try {
          val md: MessageDigest = MessageDigest.getInstance("SHA")
          md.update(signature.toByteArray())
          return Base64.encodeToString(md.digest(), Base64.NO_WRAP)
        } catch (e: NoSuchAlgorithmException){
          Log.e(LOG_TAG, "Unable to get MessageDigest. signature=$signature", e)
        }
      }
    }catch (e: Exception){
      e.printStackTrace()
      return null
    }
    return null
  }

}
