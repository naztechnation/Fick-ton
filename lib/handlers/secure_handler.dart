import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class StorageHandler {
  static const String lastLoginTimeKey = 'lastLoginTime';

  static FlutterSecureStorage storage = const FlutterSecureStorage();


  static Future<bool> isLoggedIn() async {
    final lastLoginTime = await storage.read(key: lastLoginTimeKey);
    if (lastLoginTime == null) return false;

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final twoDaysInMilliseconds = 2 * 24 * 60 * 60 * 1000; 

    return (currentTime - int.parse(lastLoginTime)) < twoDaysInMilliseconds;
  }

    static Future<void> login() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    await storage.write(key: lastLoginTimeKey, value: currentTime.toString());
  }

  static Future<void> logout() async {
    await storage.delete(key: lastLoginTimeKey);
  }

  static Future<void> saveUserDetails([String? userData]) async {
    if (userData != null) {
      await storage.write(key: 'USER', value: userData);
    }
  }

   static Future<void> saveUserEmail([String? email]) async {
    if (email != null) {
      await storage.write(key: 'EMAIL', value: email);
    }
  }

   static Future<void> saveUserGender([String? email]) async {
    if (email != null) {
      await storage.write(key: 'GENDER', value: email);
    }
  }

   static Future<void> saveUserPhone([String? email]) async {
    if (email != null) {
      await storage.write(key: 'PHONE', value: email);
    }
  }

  static Future<void> saveUserAdmin([String? email]) async {
    if (email != null) {
      await storage.write(key: 'ADMIN', value: email);
    }
  }

   static Future<void> saveUserPassword([String? email]) async {
    if (email != null) {
      await storage.write(key: 'PASSWORD', value: email);
    }
  }

  static Future<void> saveUserToken([String? token]) async {
    if (token != null) {
      await storage.write(key: 'TOKEN', value: token);
    }
  }

   static Future<void> saveOnboardState([String? onBoard]) async {
    if (onBoard != null)
      await storage.write(key: 'ONBOARD', value: onBoard);
  }

  static Future<void> saveIsLoggedIn([String? isLoggedIn]) async {
    if (isLoggedIn != null)
      await storage.write(key: 'LOGGEDIN', value: isLoggedIn);
  }

  static Future<String?> getUserEmail() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['EMAIL'];
    if (data != null) {
      user = data;
    }
    return user;
  }

  static Future<String?> getUserAdmin() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['ADMIN'];
    if (data != null) {
      user = data;
    }
    return user;
  }

   static Future<String?> getUserGender() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['GENDER'];
    if (data != null) {
      user = data;
    }
    return user;
  }
   static Future<String?> getUserPhone() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['PHONE'];
    if (data != null) {
      user = data;
    }
    return user;
  }

   static Future<String?> getUserPassword() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['PASSWORD'];
    if (data != null) {
      user = data;
    }
    return user;
  }

   static Future<String?> getUserToken() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['TOKEN'];
    if (data != null) {
      user = data;
    }
    return user;
  }

  static Future<String?> getUserDetails() async {
    Map<String, String> value = await storage.readAll();
    String? user;
    String? data = value['USER'];
    if (data != null) {
      user = data;
    }
    return user;
  }

  static Future<String> getOnBoardState() async {
   String? value = await storage.read(key: 'ONBOARD');
    String? onboard;
    String? data = value;
    if (data != null) {
      onboard = data;
    }else{
      onboard = '';
    }
    return onboard;
  }

  static Future<String> getLoggedInState() async {
   String? value = await storage.read(key: 'LOGGEDIN');
    String? loggedin;
    String? data = value;
    if (data != null) {
      loggedin = data;
    }else{
      loggedin = '';
    }
    return loggedin;
  }

 

  static Future<void> clearUserDetails() async {
    await storage.delete(key: 'USER');
  }

  static Future<void> clearCache() async {
    // Delete all saved data
    await storage.deleteAll();
  }

  static Future<void> saveCartDetails(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> getCartDetails(
      {required String key}) async {
    String? value = await storage.read(key: key);

    return value;
  }
}
