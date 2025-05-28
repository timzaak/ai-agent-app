import 'package:cloudflare_turnstile/cloudflare_turnstile.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

// TODO: Replace '1x00000000000000000000BB' with your actual Cloudflare Turnstile site key.
const String _siteKey = '1x00000000000000000000BB';

/// Retrieves the Cloudflare Turnstile token using invisible mode.
///
/// Returns the token [String] on success, or `null` if an error occurs or captcha fails.
Future<String?> getTurnstileToken() async {
  final turnstile = CloudflareTurnstile.invisible(
    siteKey: _siteKey,
    // You can configure other options here if needed, e.g.,
    // options: const TurnstileOptions(
    //   mode: TurnstileMode.invisible,
    // ),
  );

  try {
    final String? token = await turnstile.getToken();
    if (token != null && kDebugMode) {
      print('Turnstile token: $token');
    }
    return token;
  } on TurnstileException catch (e) {
    if (kDebugMode) {
      print('Turnstile challenge failed: ${e.message}');
    }
    return null;
  } finally {
    turnstile.dispose();
  }
}
