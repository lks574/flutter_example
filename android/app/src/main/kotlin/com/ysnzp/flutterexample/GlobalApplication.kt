package com.ysnzp.flutterexample

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

// 어플리케이션 컴포넌트들 사이에서 공동으로 멤버들을 사용할 수 있게 해주는 공유 클래스
class GlobalApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
    }

    override fun registerWith(p0: PluginRegistry?) {
        if (p0 == null){
            return
        }
        GeneratedPluginRegistrant.registerWith(p0)
    }
}
