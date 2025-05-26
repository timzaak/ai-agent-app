import 'package:dio/dio.dart';

import '../config/settings.dart';
import '../util/local_storage.dart';

//import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:youliao/app.dart';
// import 'package:youliao/config/settings.dart';
// import 'package:youliao/pages/login/login_page.dart';
// import 'package:youliao/utils/tools_util/data/local_store.dart';

class DioTokenInterceptors extends Interceptor {
  String? _token;
  //
  // @override
  // void onRequest(
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   if (_token == null) {
  //     _token = await getAuthorization();
  //   }
  //   if (_token != null) {
  //     options.headers[Settings.TOKEN_KEY] = _token;
  //   }
  //   return super.onRequest(options, handler);
  // }
  //
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) async {
  //   // 响应前需要做刷新token的操作
  //   super.onResponse(response, handler);
  // }
  //
  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   if (err.type == DioErrorType.response && err.response?.statusCode == 401) {
  //     SmartDialog.showToast('登录信息失效，请重新登录');
  //     clearAuthorization();
  //     navigatorKey.currentState
  //         ?.pushNamedAndRemoveUntil(LoginPage.sName, (route) => false);
  //   } else {
  //     super.onError(err, handler);
  //   }
  // }
  //
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Settings.TOKEN_KEY);
  }

  setAuthorization(String token) async {
    await LocalStorage.save(Settings.TOKEN_KEY, token);
    this._token = token;
  }

  Future<String?> getAuthorization() async {
    if(this._token == null) {
      String? token = await LocalStorage.get(Settings.TOKEN_KEY);
      if (token != null) {
        this._token = token;
      }
      return token;
    }
    return this._token;
  }
}