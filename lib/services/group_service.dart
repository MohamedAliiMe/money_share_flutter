import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/group.dart';
import '../utils/constants.dart';

class GroupService {
  final String baseUrl = Constants.apiUrl;
  Future<Map<String, String>> get headers => Constants.getHeaders();

  Future<List<Group>> getGroups() async {
    try {
      log('Fetching groups from: $baseUrl/groups');
      final headers = await this.headers;
      log('Headers: $headers');

      final response = await http.get(
        Uri.parse('$baseUrl/groups'),
        headers: headers,
      );

      log('Groups API Response - Status: ${response.statusCode}');
      log('Groups API Response - Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log('Decoded response data: $responseData');

        if (responseData is List) {
          return responseData.map((json) => Group.fromJson(json)).toList();
        } else if (responseData is Map && responseData.containsKey('groups')) {
          final groups = responseData['groups'] as List;
          return groups.map((json) => Group.fromJson(json)).toList();
        } else {
          throw Exception('Invalid response format: ${response.body}');
        }
      } else {
        throw Exception('Failed to load groups: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      log('Error in getGroups: $e');
      log('Stack trace: $stackTrace');
      throw Exception('Failed to load groups: $e');
    }
  }

  Future<Group> createGroup(String name, List<int> memberIds) async {
    final response = await http.post(
      Uri.parse('$baseUrl/groups'),
      headers: await headers,
      body: jsonEncode({
        'name': name,
        'member_ids': memberIds,
      }),
    );
    log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Group.fromJson(data);
    } else {
      throw Exception('Failed to create group');
    }
  }

  Future<void> addMemberToGroup(int groupId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/groups/$groupId/members'),
      headers: await headers,
      body: jsonEncode({
        'user_id': userId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add member to group');
    }
  }

  Future<void> removeMemberFromGroup(int groupId, int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/groups/$groupId/members/$userId'),
      headers: await headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove member from group');
    }
  }
}
