import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/constants.dart';

class AuthService {
  final String baseUrl = Constants.apiUrl;
  Future<Map<String, String>> get headers => Constants.getHeaders();

  Future<User> login(String email, String password) async {
    developer.log('Attempting login with email: $email');
    developer.log('Login URL: $baseUrl/login');
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      developer.log('Login response status: ${response.statusCode}');
      developer.log('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        final user = User.fromJson(data['user']);
        await prefs.setString('user', jsonEncode(data['user']));
        return user;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      developer.log('Login error: $e');
      rethrow;
    }
  }

  Future<User> register(String name, String email, String password,
      String passwordConfirmation) async {
    developer.log('Attempting registration with email: $email');
    developer.log('Register URL: $baseUrl/register');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      developer.log('Register response status: ${response.statusCode}');
      developer.log('Register response body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        final user = User.fromJson(data['user']);
        await prefs.setString('user', jsonEncode(data['user']));
        return user;
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      developer.log('Register error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    developer.log('Attempting logout');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: await headers,
      );

      developer.log('Logout response status: ${response.statusCode}');
      developer.log('Logout response body: ${response.body}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');

      if (response.statusCode != 200) {
        throw Exception('Failed to logout: ${response.body}');
      }
    } catch (e) {
      developer.log('Logout error: $e');
      rethrow;
    }
  }

  Future<User?> loadSavedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      final token = prefs.getString('token');

      developer.log('Loading saved user session...');
      developer.log('Found token: ${token != null}');
      developer.log('Found user data: ${userJson != null}');

      if (userJson != null && token != null) {
        return User.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      developer.log('Load saved user error: $e');
      return null;
    }
  }
}
