import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FCMService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  // 初始化FCM
  static Future<void> initialize() async {
    // 请求通知权限
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('用户已授权通知权限');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('用户已授权临时通知权限');
    } else {
      log('用户拒绝了通知权限');
    }

    // 获取FCM token
    String? token = await getToken();
    if (token != null) {
      log('FCM Token: $token');
      // 这里可以将token发送到你的服务器
    }

    // 监听token刷新
    _firebaseMessaging.onTokenRefresh.listen((String token) {
      log('FCM Token 已刷新: $token');
      // 这里可以将新token发送到你的服务器
    });

    // 设置前台消息处理
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // 设置后台消息处理
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    
    // 检查应用是否通过通知启动
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  // 获取FCM token
  static Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      return token;
    } catch (e) {
      log('获取FCM token失败: $e');
      return null;
    }
  }

  // 订阅主题
  static Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      log('已订阅主题: $topic');
    } catch (e) {
      log('订阅主题失败: $e');
    }
  }

  // 取消订阅主题
  static Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      log('已取消订阅主题: $topic');
    } catch (e) {
      log('取消订阅主题失败: $e');
    }
  }

  // 处理前台消息
  static void _handleForegroundMessage(RemoteMessage message) {
    log('收到前台消息: ${message.messageId}');
    log('标题: ${message.notification?.title}');
    log('内容: ${message.notification?.body}');
    log('数据: ${message.data}');
    
    // 这里可以显示应用内通知或处理数据
    _showNotification(message);
  }

  // 处理后台消息（用户点击通知）
  static void _handleBackgroundMessage(RemoteMessage message) {
    log('用户点击了通知: ${message.messageId}');
    log('标题: ${message.notification?.title}');
    log('内容: ${message.notification?.body}');
    log('数据: ${message.data}');
    
    // 这里可以根据消息数据进行页面跳转等操作
    _handleNotificationTap(message);
  }

  // 显示通知（前台时）
  static void _showNotification(RemoteMessage message) {
    // 这里可以使用flutter_smart_dialog或其他方式显示通知
    // 由于你已经使用了flutter_smart_dialog，可以这样显示：
    /*
    SmartDialog.showToast(
      '${message.notification?.title}\n${message.notification?.body}',
      displayTime: const Duration(seconds: 3),
    );
    */
  }

  // 处理通知点击
  static void _handleNotificationTap(RemoteMessage message) {
    // 根据消息数据进行相应的页面跳转
    // 例如：
    /*
    if (message.data.containsKey('page')) {
      String page = message.data['page'];
      // 使用go_router进行页面跳转
      // context.go('/page/$page');
    }
    */
  }
}

// 后台消息处理函数（必须是顶级函数）
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('处理后台消息: ${message.messageId}');
  log('标题: ${message.notification?.title}');
  log('内容: ${message.notification?.body}');
  log('数据: ${message.data}');
}