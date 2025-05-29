// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get passwordLogin => 'Password Login';

  @override
  String get verificationCodeLogin => 'Verification Code Login';

  @override
  String get enterEmail => 'Please enter email';

  @override
  String get enterPassword => 'Please enter password';

  @override
  String get enterVerificationCode => 'Please enter verification code';

  @override
  String get getVerificationCode => 'Get Code';

  @override
  String resendCode(Object seconds) {
    return 'Resend ($seconds)';
  }

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get submit => 'Submit';

  @override
  String get changePassword => 'Change Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get userAgreement => 'User Agreement';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get iHaveReadAndAgree => 'I have read and agree to';

  @override
  String get and => 'and';

  @override
  String get unregisteredEmailWillCreateAccount => 'Unregistered email will automatically create an account';

  @override
  String get myAccount => 'My Account';

  @override
  String get logout => 'Logout';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountConfirm => 'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get deletingAccount => 'Deleting account...';

  @override
  String get accountDeletedSuccess => 'Account deleted successfully.';

  @override
  String get requiresRecentLogin => 'This operation is sensitive and requires recent authentication. Please log in again before retrying.';

  @override
  String unexpectedError(Object error) {
    return 'An unexpected error occurred: $error';
  }

  @override
  String get videoError => 'Video Error';

  @override
  String get initializingPlayer => 'Initializing player...';

  @override
  String get noVideosFound => 'No videos found';

  @override
  String get videoList => 'Video List';

  @override
  String time(Object time) {
    return 'Time: $time';
  }

  @override
  String device(Object name) {
    return 'Device: $name';
  }

  @override
  String get myDevices => 'My Devices';

  @override
  String get scanQrToAddDevice => 'Scan QR code to add device';

  @override
  String get infiniteScroll => 'Infinite Scroll';

  @override
  String get noMoreItems => 'No more items';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String loginFailed(Object error) {
    return 'Login failed: $error';
  }

  @override
  String logoutFailed(Object error) {
    return 'Logout failed: $error';
  }

  @override
  String get googleLoginSuccess => 'Google login successful';

  @override
  String googleLoginFailed(Object error) {
    return 'Google login failed: $error';
  }

  @override
  String get facebookLoginSuccess => 'Facebook login successful';

  @override
  String facebookLoginFailed(Object error) {
    return 'Facebook login failed: $error';
  }

  @override
  String get pleaseAgreeToTerms => 'Please read and agree to the User Agreement and Privacy Policy';
}
