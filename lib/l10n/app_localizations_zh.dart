// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get login => '登录';

  @override
  String get passwordLogin => '密码登录';

  @override
  String get verificationCodeLogin => '验证码登录';

  @override
  String get enterEmail => '请输入邮箱';

  @override
  String get enterPassword => '请输入密码';

  @override
  String get enterVerificationCode => '请输入验证码';

  @override
  String get getVerificationCode => '获取验证码';

  @override
  String resendCode(Object seconds) {
    return '重新发送($seconds)';
  }

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get submit => '提交';

  @override
  String get changePassword => '修改密码';

  @override
  String get resetPassword => '重置密码';

  @override
  String get userAgreement => '用户协议';

  @override
  String get privacyPolicy => '隐私保护协议';

  @override
  String get iHaveReadAndAgree => '我已阅读并同意';

  @override
  String get and => '和';

  @override
  String get unregisteredEmailWillCreateAccount => '未注册的邮箱验证后自动创建账号';

  @override
  String get myAccount => '我的账号';

  @override
  String get logout => '退出登录';

  @override
  String get deleteAccount => '删除账号';

  @override
  String get deleteAccountConfirm => '您确定要删除账号吗？此操作无法撤销。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get deletingAccount => '正在删除账号...';

  @override
  String get accountDeletedSuccess => '账号已成功删除。';

  @override
  String get requiresRecentLogin => '此操作较为敏感，需要重新登录验证。请重新登录后再试。';

  @override
  String unexpectedError(Object error) {
    return '发生意外错误：$error';
  }

  @override
  String get videoError => '视频错误';

  @override
  String get initializingPlayer => '正在初始化播放器...';

  @override
  String get noVideosFound => '未找到视频';

  @override
  String get videoList => '视频列表';

  @override
  String time(Object time) {
    return '时间：$time';
  }

  @override
  String device(Object name) {
    return '设备：$name';
  }

  @override
  String get myDevices => '我的设备';

  @override
  String get scanQrToAddDevice => '扫描二维码添加设备';

  @override
  String get infiniteScroll => '无限滚动';

  @override
  String get noMoreItems => '没有更多内容';

  @override
  String get loginSuccess => '登录成功';

  @override
  String loginFailed(Object error) {
    return '登录失败：$error';
  }

  @override
  String logoutFailed(Object error) {
    return '退出登录失败：$error';
  }

  @override
  String get googleLoginSuccess => 'Google登录成功';

  @override
  String googleLoginFailed(Object error) {
    return 'Google登录失败：$error';
  }

  @override
  String get facebookLoginSuccess => 'Facebook登录成功';

  @override
  String facebookLoginFailed(Object error) {
    return 'Facebook登录失败：$error';
  }

  @override
  String get pleaseAgreeToTerms => '请阅读并同意用户协议和隐私保护协议';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get login => '登入';

  @override
  String get passwordLogin => '密碼登入';

  @override
  String get verificationCodeLogin => '驗證碼登入';

  @override
  String get enterEmail => '請輸入電子郵件';

  @override
  String get enterPassword => '請輸入密碼';

  @override
  String get enterVerificationCode => '請輸入驗證碼';

  @override
  String get getVerificationCode => '獲取驗證碼';

  @override
  String resendCode(Object seconds) {
    return '重新發送($seconds)';
  }

  @override
  String get forgotPassword => '忘記密碼？';

  @override
  String get submit => '提交';

  @override
  String get changePassword => '修改密碼';

  @override
  String get resetPassword => '重設密碼';

  @override
  String get userAgreement => '用戶協議';

  @override
  String get privacyPolicy => '隱私保護協議';

  @override
  String get iHaveReadAndAgree => '我已閱讀並同意';

  @override
  String get and => '和';

  @override
  String get unregisteredEmailWillCreateAccount => '未註冊的電子郵件驗證後自動創建帳號';

  @override
  String get myAccount => '我的帳號';

  @override
  String get logout => '登出';

  @override
  String get deleteAccount => '刪除帳號';

  @override
  String get deleteAccountConfirm => '您確定要刪除帳號嗎？此操作無法撤銷。';

  @override
  String get cancel => '取消';

  @override
  String get delete => '刪除';

  @override
  String get deletingAccount => '正在刪除帳號...';

  @override
  String get accountDeletedSuccess => '帳號已成功刪除。';

  @override
  String get requiresRecentLogin => '此操作較為敏感，需要重新登入驗證。請重新登入後再試。';

  @override
  String unexpectedError(Object error) {
    return '發生意外錯誤：$error';
  }

  @override
  String get videoError => '視頻錯誤';

  @override
  String get initializingPlayer => '正在初始化播放器...';

  @override
  String get noVideosFound => '未找到視頻';

  @override
  String get videoList => '視頻列表';

  @override
  String time(Object time) {
    return '時間：$time';
  }

  @override
  String device(Object name) {
    return '設備：$name';
  }

  @override
  String get myDevices => '我的設備';

  @override
  String get scanQrToAddDevice => '掃描二維碼添加設備';

  @override
  String get infiniteScroll => '無限滾動';

  @override
  String get noMoreItems => '沒有更多內容';

  @override
  String get loginSuccess => '登入成功';

  @override
  String loginFailed(Object error) {
    return '登入失敗：$error';
  }

  @override
  String logoutFailed(Object error) {
    return '登出失敗：$error';
  }

  @override
  String get googleLoginSuccess => 'Google登入成功';

  @override
  String googleLoginFailed(Object error) {
    return 'Google登入失敗：$error';
  }

  @override
  String get facebookLoginSuccess => 'Facebook登入成功';

  @override
  String facebookLoginFailed(Object error) {
    return 'Facebook登入失敗：$error';
  }

  @override
  String get pleaseAgreeToTerms => '請閱讀並同意用戶協議和隱私保護協議';
}
