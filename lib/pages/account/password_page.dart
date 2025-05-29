import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/validator.dart';
import '../../util/turnstile_util.dart';
import '../../l10n/app_localizations.dart';
import 'password_type.dart';

class ChangePasswordPage extends HookConsumerWidget {
  static const sName = 'password';
  final ChangePasswordType type;

  const ChangePasswordPage({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
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
        title: Text(type == ChangePasswordType.ForgotPassword ? l10n.forgotPassword : l10n.changePassword),
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
                decoration: InputDecoration(labelText: l10n.enterEmail),
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
                      decoration: InputDecoration(labelText: l10n.enterVerificationCode),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.enterVerificationCode;
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
                            if (formKey.currentState?.validate() ?? false) {
                              print('Requesting verification code for ${emailController.text}');
                              startTimer();
                            }
                          },
                    child: Text(
                      isCounting.value 
                          ? l10n.resendCode(countdown.value.toString())
                          : l10n.getVerificationCode,
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
                  if (formKey.currentState?.validate() ?? false) {
                    print('Submitting form with email: ${emailController.text} and code: ${codeController.text}');
                  }
                },
                child: Text(l10n.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
