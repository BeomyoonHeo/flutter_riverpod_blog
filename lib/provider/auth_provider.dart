import 'package:blog/domain/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider =
    Provider<AuthProvider>((ref) => AuthProvider(ref)..initJwtToken());

class AuthProvider {
  Ref _ref;
  User? user;
  late final jwtToken;
  bool isLogin = false;

  AuthProvider(this._ref);

  Future<void> initJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceJwtToken = prefs.getString("jwtToken");
    Logger().d("토큰 저장됨?");
    if (deviceJwtToken != null) {
      Logger().d("토큰이 있음");
      Logger().d("${deviceJwtToken}");
      isLogin = true;
      jwtToken = deviceJwtToken;
      //통신코드로 user 초기화
      // http://ip주소:8080/userData (Get, Header)
    }
  }
}
