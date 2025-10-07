import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/home/domain/model/user.dart';
import '../core/utils/constants.dart';

class UserService {
  final String baseUrl = Constants.apiUrl;
  Future<Map<String, String>> get headers => Constants.getHeaders();

  Future<List<UserModel>> getAllUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: await headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<UserModel>> searchUsers(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/search?query=$query'),
      headers: await headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }
}
