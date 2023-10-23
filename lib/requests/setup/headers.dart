
import '../../res/app_strings.dart';

Future<Map<String, String>> rawDataHeader([String? token]) async {
  final accessToken = token;
  return {
    'Content-Type': 'application/json',
    if (accessToken != null) 'Authorization': accessToken,
  };
}

Future<Map<String, String>> formDataHeader([String? token]) async {
   
  return {
    'Authorization': '',
  };
}