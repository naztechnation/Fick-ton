
import '../../handlers/secure_handler.dart';
import '../../res/app_strings.dart';

Future<Map<String, String>> rawDataHeader([String? token]) async {
final accessToken = await StorageHandler.getUserToken() ?? '';

  return {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': accessToken,
  };
}

Future<Map<String, String>> formDataHeader([String? token]) async {
  final accessToken = await StorageHandler.getUserToken() ?? '';

  return {
   'Accept': 'application/json',
  //'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };
}