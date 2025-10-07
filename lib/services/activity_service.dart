import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';
import '../core/utils/constants.dart';
import 'dart:developer' as developer;

class ActivityService {
  Future<List<ActivityModel>> getActivities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('No authentication token found');
      }
      developer.log('Activities URL: ${Constants.apiUrl}/activities');
      final response = await http.get(
        Uri.parse('${Constants.apiUrl}/activities'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      developer.log('Activities response status: ${response.statusCode}');
      developer.log('Activities response body: ${response.body}');
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => ActivityModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load activities');
      }
    } catch (e) {
      throw Exception('Error fetching activities: $e');
    }
  }
}
