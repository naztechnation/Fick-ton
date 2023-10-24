import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class StorageHandler {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

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

  static Future<void> saveUserToken([String? token]) async {
    if (token != null) {
      await storage.write(key: 'TOKEN', value: token);
    }
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
