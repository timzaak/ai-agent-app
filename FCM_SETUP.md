# Firebase Cloud Messaging (FCM) 集成指南

## 已完成的配置

### 1. 依赖添加
- ✅ 已在 `pubspec.yaml` 中添加 `firebase_messaging: ^15.1.6`
- ✅ 已更新依赖包

### 2. Android 配置
- ✅ 已在 `android/build.gradle.kts` 中添加 Google Services 插件
- ✅ 已在 `android/app/build.gradle.kts` 中应用 Google Services 插件
- ✅ 已在 `AndroidManifest.xml` 中添加必要权限和配置
- ✅ 已创建通知图标和颜色资源

### 3. Flutter 代码
- ✅ 已创建 `FCMService` 服务类
- ✅ 已在 `main.dart` 中初始化 FCM
- ✅ 已创建 FCM 演示页面
- ✅ 已添加路由配置

## 还需要完成的配置

### 1. Firebase 项目配置
1. 在 [Firebase Console](https://console.firebase.google.com/) 创建项目
2. 添加 Android 应用，包名为：`com.aliencell.app`
3. 下载 `google-services.json` 文件
4. 将 `google-services.json` 放置到 `android/app/` 目录下

### 2. iOS 配置（如果需要）
1. 在 Firebase Console 中添加 iOS 应用
2. 下载 `GoogleService-Info.plist` 文件
3. 将文件添加到 iOS 项目中
4. 配置 APNs 证书

## 使用方法

### 1. 访问演示页面
在应用中导航到 `/fcm_demo` 路径，或者在代码中使用：
```dart
context.go('/fcm_demo');
```

### 2. 获取 FCM Token
```dart
String? token = await FCMService.getToken();
```

### 3. 订阅/取消订阅主题
```dart
await FCMService.subscribeToTopic('news');
await FCMService.unsubscribeFromTopic('news');
```

### 4. 处理消息
- 前台消息：在 `FCMService._handleForegroundMessage` 中处理
- 后台消息：在 `FCMService._handleBackgroundMessage` 中处理
- 应用启动消息：自动检测并处理

## 测试推送通知

### 1. 使用 Firebase Console
1. 进入 Firebase Console > Cloud Messaging
2. 点击"发送您的第一条消息"
3. 输入通知标题和正文
4. 选择目标（应用或主题）
5. 发送测试消息

### 2. 使用 FCM Token
1. 在演示页面复制 FCM Token
2. 在 Firebase Console 中选择"发送测试消息"
3. 粘贴 Token 并发送

### 3. 使用主题
1. 在演示页面订阅主题（如 "news"）
2. 在 Firebase Console 中选择主题发送
3. 输入主题名称并发送消息

## 注意事项

1. **权限**：应用首次启动时会请求通知权限
2. **前台消息**：应用在前台时，消息不会显示系统通知，需要自定义处理
3. **后台消息**：应用在后台时，点击通知会触发 `onMessageOpenedApp` 回调
4. **数据消息**：可以在消息中包含自定义数据进行页面跳转等操作
5. **Token 刷新**：FCM Token 可能会刷新，需要监听并更新到服务器

## 自定义配置

### 修改通知图标
编辑 `android/app/src/main/res/drawable/ic_stat_ic_notification.xml`

### 修改通知颜色
编辑 `android/app/src/main/res/values/colors.xml` 中的 `colorAccent`

### 自定义消息处理
在 `FCMService` 中修改 `_handleForegroundMessage` 和 `_handleBackgroundMessage` 方法