


String? validateEmail(String? text) {
  if (text == null || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(text)) {
    return '邮箱地址格式不正确';
  }
  return null;
}