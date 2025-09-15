import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  // Use 10.0.2.2 for Android emulator, your machine's IP address for real devices
  static const String apiUrl = 'https://yalla.redgits.com/splitwise/api';

  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    developer.log('Auth token: $token');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    developer.log('Request headers: $headers');
    return headers;
  }
}
