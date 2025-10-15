package com.dixoraclecore

import android.os.Bundle
import android.webkit.WebView
import androidx.activity.ComponentActivity

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val webView = WebView(this)
        webView.settings.javaScriptEnabled = true
        webView.loadUrl("http://10.0.2.2:5173") // Cambia la IP si usas dispositivo físico
        setContentView(webView)
    }
}
