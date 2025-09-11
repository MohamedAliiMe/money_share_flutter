import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  static const String baseUrl = 'http://192.168.0.114:8000/api';  // Your computer's local IP address
  static const String tokenKey = 'token';

  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
