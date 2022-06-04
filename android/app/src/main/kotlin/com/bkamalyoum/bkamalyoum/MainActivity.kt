package com.bkamalyoum.bkamalyoum

import io.flutter.embedding.android.FlutterActivity

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import java.io.File;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

//import android.support.v4.content.FileProvider;

class MainActivity: FlutterActivity() {
}

//    private val SHARE_CHANNEL = "channel:me.albie.share/share"
//
//    @Override
//    protected fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)

//        GeneratedPluginRegistrant.registerWith(this)
//        MethodChannel(this.getFlutterView(), SHARE_CHANNEL).setMethodCallHandler(object : MethodCallHandler() {
//            fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result?) {
//                if (methodCall.method.equals("shareFile")) {
//                    shareFile((methodCall.arguments as String))
//                }
//            }
//        })
//    }

//    private fun shareFile(path: String) {
//        val imageFile = File(this.getApplicationContext().getCacheDir(), path)
//        val contentUri: Uri = FileProvider.getUriForFile(this, "me.albie.share", imageFile)
//        val shareIntent = Intent(Intent.ACTION_SEND)
//        shareIntent.setType("image/jpg")
//        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri)
//        this.startActivity(Intent.createChooser(shareIntent, "Share image using"))
//    }
