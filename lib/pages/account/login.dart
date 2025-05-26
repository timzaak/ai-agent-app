import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_plugin/flutter_color_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


String? _validateEmail(String? text) {
  if (text == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
    return '邮箱地址格式不正确';
  }
  return null;
}

class LoginPage extends HookConsumerWidget {
  static const sName = 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final codeController = useTextEditingController();
    final seconds = useState<int?>(null);
    final agreeDeal = useState<bool>(false);
    final timer = useRef<Timer?>(null);

    useEffect(() {
      return () {
        emailController.dispose();
        codeController.dispose();
        timer.value?.cancel();
      };
    }, []);

    void _getCode() async {
      if (seconds.value == null) {
        var v = _validateEmail(emailController.text.trim());
        if(v != null) {
          SmartDialog.showToast(v);
        }
        seconds.value = 60;
        timer.value = Timer.periodic(const Duration(seconds: 1), (_) {
          if (seconds.value != null) {
            seconds.value = seconds.value! - 1;
            if (seconds.value == 0) {
              timer.value?.cancel();
              seconds.value = null;
            }
          }
        });
        /*
        await dio.post('/sms/code',
            queryParameters: {'mobile': _mobileController.text.trim()});
        */
      }
    }

    void _handleLogin() async {
      /*
      if (_formKey.currentState?.validate() == true) {
        if (agreeDeal.value) {
          // ... existing login logic
        } else {
          SmartDialog.showToast('请阅读并同意用户协议和隐私保护协议');
        }
      }
      */
    }

    void _goPdf(String name, String path) {
      /*
      Navigator.of(context).pushNamed(PdfViewerPage.sName,
          arguments: PdfViewerPageArg(
              url: '???',
              name: name));
      */
    }

    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 26, right: 26, top: 0, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.12.sh),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: '请输入邮箱',
                      ),
                      validator: (text) {
                        return _validateEmail(text);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '请输入验证码',
                        suffixIcon: TextButton(
                          onPressed: _getCode,
                          child: Text(seconds.value == null
                              ? '获取验证码'
                              : '重新发送(${seconds.value})'),
                        ),
                      ),
                      validator: (text) {
                        if (text == null) {
                          return '请输入验证码';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => agreeDeal.value = !agreeDeal.value,
                      child: Text.rich(
                        textAlign: TextAlign.start,
                        style: const TextStyle(height: 1.5, fontSize: 12),
                        TextSpan(children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Checkbox(
                                value: agreeDeal.value,
                                shape: const CircleBorder(),
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                onChanged: (_) => agreeDeal.value = !agreeDeal.value,
                              ),
                            ),
                          ),
                          const TextSpan(text: '我已阅读并同意'),
                          TextSpan(
                            text: '《用户协议》',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _goPdf('用户协议', 'user_deal.pdf'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '、'),
                          TextSpan(
                            text: '《隐私保护协议》',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _goPdf('隐私保护协议', 'privacy_protect.pdf'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: '，未注册的邮箱验证后自动创建账号'),
                        ]),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _handleLogin,
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          '登录',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}