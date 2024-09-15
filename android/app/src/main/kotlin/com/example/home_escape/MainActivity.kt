package com.example.home_escape

import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // 通知チャンネルの作成（APIレベル26以上）
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "high_importance_channel"
            val channelName = "High Importance Notifications"
            val channelDescription = "This channel is used for important notifications."
            val importance = NotificationManager.IMPORTANCE_HIGH  // 高優先度（ヘッドアップ通知）

            // チャンネルを作成
            val channel = NotificationChannel(channelId, channelName, importance)
            channel.description = channelDescription

            // NotificationManagerにチャンネルを登録
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}
