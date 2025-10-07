import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../models/friend.dart';
import '../core/utils/constants.dart';

class FriendService {
  final String baseUrl = Constants.apiUrl;

  Future<List<Friend>> getFriends() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/friends'),
        headers: await Constants.getHeaders(),
      );

      developer.log('Friends API Response - Status: ${response.statusCode}');
      developer.log('Friends API Response - Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        developer.log('Decoded response data: $responseData');
        
        final List<dynamic> data = responseData['friends'] ?? [];
        return data.map((json) => Friend.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load friends: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Error loading friends: $e');
      throw Exception('Failed to load friends: $e');
    }
  }

  Future<void> sendFriendRequest(int friendId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/friends/request'),
      headers: await Constants.getHeaders(),
      body: json.encode({'friend_id': friendId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send friend request');
    }
  }

  Future<void> acceptFriendRequest(int friendshipId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/friends/accept/$friendshipId'),
      headers: await Constants.getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to accept friend request');
    }
  }

  Future<List<Friend>> searchUsers(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/friends/search?query=$query'),
      headers: await Constants.getHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['users'];
      return data.map((json) => Friend.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search users');
    }
  }

  Future<String> generateQrCode() async {
    final response = await http.get(
      Uri.parse('$baseUrl/friends/qr-code'),
      headers: await Constants.getHeaders(),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['qr_data'];
    } else {
      throw Exception('Failed to generate QR code');
    }
  }
}
