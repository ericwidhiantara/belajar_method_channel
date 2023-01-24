package com.example.belajar_method_channel

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.random.Random


//MethodChannelHandler.kt
class RandomDataChannel(private val flutterEngine: FlutterEngine) {
    private val randomDataChannel = "example1"

    fun setMethodCallHandler(){
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, randomDataChannel).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getRandomNumber" -> {
                    val rand = Random.nextInt(100)
                    result.success(rand)
                }
                "getRandomString" -> {
                    val rand = ('a'..'z').shuffled().take(4).joinToString("")
                    result.success(rand)
                }
                "getRandomStringFromFlutter" -> {
                    val limit = call.argument("len") ?: 4
                    val prefix = call.argument("prefix") ?: ""
                    val rand = ('a'..'z')
                        .shuffled()
                        .take(limit)
                        .joinToString(prefix = prefix, separator = "")
                    result.success(rand)
                }
                else -> {
                    result.notImplemented()
                }
            }
//            if(call.method == "getRandomNumber") {
//                val rand = Random.nextInt(100)
//                result.success(rand)
//            }
//            else if(call.method == "getRandomString") {
//                val rand = ('a'..'z').shuffled().take(4).joinToString("")
//                result.success(rand)
//            }
//            else if(call.method == "getRandomStringFromFlutter") {
//                val limit = call.argument("len") ?: 4
//                val prefix = call.argument("prefix") ?: ""
//                val rand = ('a'..'z')
//                    .shuffled()
//                    .take(limit)
//                    .joinToString(prefix = prefix, separator = "")
//                result.success(rand)
//            }
//            else {
//                result.notImplemented()
//            }
        }

    }

}
