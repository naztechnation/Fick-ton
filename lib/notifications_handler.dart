import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStateManager {
  static const String lastLoginTimeKey = 'lastLoginTime';
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<bool> isLoggedIn() async {
    final lastLoginTime = await _storage.read(key: lastLoginTimeKey);
    if (lastLoginTime == null) return false;

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final twoDaysInMilliseconds = 2 * 24 * 60 * 60 * 1000; 

    return (currentTime - int.parse(lastLoginTime)) < twoDaysInMilliseconds;
  }

  static Future<void> login() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await _storage.write(key: lastLoginTimeKey, value: currentTime.toString());
  }

  static Future<void> logout() async {
    await _storage.delete(key: lastLoginTimeKey);
  }
}
