import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/validator.dart';
import '../../util/turnstile_util.dart';
import 'password_type.dart';

class ChangePasswordPage extends HookConsumerWidget {
  static const sName = 'password';
  final ChangePasswordType type; // Updated type

  const ChangePasswordPage({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final codeController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final countdown = useState(0);
    final isCounting = useState(false);

    void startTimer() {
      countdown.value = 60;
      isCounting.value = true;
      Future.doWhile(() async {
        await Future.delayed(const Duration(seconds: 1));
        if (countdown.value > 0) {
          countdown.value--;
        }
        if (countdown.value == 0) {
          isCounting.value = false;
          return false; // stop the timer
        }
        return true; // continue the timer
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(type == ChangePasswordType.ForgotPassword ? '忘记密码' : '修改密码'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: '邮箱'),
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: codeController,
                      decoration: const InputDecoration(labelText: '验证码'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入验证码';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  TextButton(
                    onPressed: isCounting.value
                        ? null
                        : () async {
                            final token = await getTurnstileToken();
                            if (token == null) {
                              print('Captcha verification failed. Please try again.');
                              return;
                            }
                            // The utility function now handles printing the token in debug mode.
                            // print('Turnstile token: $token'); 
                            if (formKey.currentState?.validate() ?? false) {
                              // TODO: Implement API call to send verification code
                              print('Requesting verification code for ${emailController.text}');
                              startTimer();
                            }
                          },
                    child: Text(
                      isCounting.value ? '重新发送(${countdown.value})' : '获取验证码',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  final token = await getTurnstileToken();
                  if (token == null) {
                    print('Captcha verification failed. Please try again.');
                    return;
                  }
                  // The utility function now handles printing the token in debug mode.
                  // print('Turnstile token: $token');
                  if (formKey.currentState?.validate() ?? false) {
                    // TODO: Implement submit logic
                    print('Submitting form with email: ${emailController.text} and code: ${codeController.text}');
                  }
                },
                child: const Text('提交'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
