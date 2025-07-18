import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/services/fcm_service.dart';

class FCMDemoPage extends StatefulWidget {
  const FCMDemoPage({super.key});

  @override
  State<FCMDemoPage> createState() => _FCMDemoPageState();
}

class _FCMDemoPageState extends State<FCMDemoPage> {
  String? _fcmToken;
  final TextEditingController _topicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    String? token = await FCMService.getToken();
    setState(() {
      _fcmToken = token;
    });
  }

  void _copyToken() {
    if (_fcmToken != null) {
      Clipboard.setData(ClipboardData(text: _fcmToken!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FCM Token 已复制到剪贴板')),
      );
    }
  }

  Future<void> _subscribeToTopic() async {
    String topic = _topicController.text.trim();
    if (topic.isNotEmpty) {
      await FCMService.subscribeToTopic(topic);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已订阅主题: $topic')),
      );
    }
  }

  Future<void> _unsubscribeFromTopic() async {
    String topic = _topicController.text.trim();
    if (topic.isNotEmpty) {
      await FCMService.unsubscribeFromTopic(topic);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已取消订阅主题: $topic')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCM 推送通知演示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FCM Token:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _fcmToken ?? '正在获取...',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _fcmToken != null ? _copyToken : null,
                    child: const Text('复制 Token'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '主题订阅:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _topicController,
              decoration: const InputDecoration(
                labelText: '主题名称',
                hintText: '例如: news, updates',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _subscribeToTopic,
                    child: const Text('订阅主题'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _unsubscribeFromTopic,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('取消订阅'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '使用说明:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1. 复制上面的 FCM Token\n'
              '2. 在 Firebase 控制台中发送测试消息\n'
              '3. 或者订阅主题后发送主题消息\n'
              '4. 应用在前台时会显示消息内容\n'
              '5. 应用在后台时点击通知会打开应用',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }
}