import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/expense.dart';
import '../utils/constants.dart';

class ExpenseService {
  final String baseUrl = Constants.apiUrl;
  Future<Map<String, String>> get headers => Constants.getHeaders();

  Future<List<Expense>> getGroupExpenses(int groupId) async {
    final response = await http.get(
      Uri.parse('${baseUrl}/groups/$groupId/expenses'),
      headers: await headers,
    );
log(response.statusCode.toString());
    log(response.body.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Expense.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }



  }

  Future<Expense> createExpense({
    required int groupId,
    required int paidById,
    required String description,
    required double amount,
    required DateTime date,
    required List<Map<String, dynamic>> splits,
  }) async {
    final requestBody = {
      'group_id': groupId,
      'paid_by': paidById,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'splits': splits,
    };
    log('Request body: ${json.encode(requestBody)}');
    
    final response = await http.post(
      Uri.parse('$baseUrl/groups/$groupId/expenses'),
      headers: await headers,
      body: json.encode(requestBody),
    );
    
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return Expense.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create expense');
    }
  }

  Future<Expense> updateExpense({
    required int id,
    required String description,
    required double amount,
    required DateTime date,
    required List<Map<String, dynamic>> splits,
  }) async {
    final response = await http.put(
      Uri.parse('${baseUrl}/expenses/$id'),
      headers: await headers,
      body: json.encode({
        'description': description,
        'amount': amount,
        'date': date.toIso8601String(),
        'splits': splits,
      }),
    );

    if (response.statusCode == 200) {
      return Expense.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update expense');
    }
  }

  Future<void> deleteExpense(int expenseId) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}/expenses/$expenseId'),
      headers: await headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete expense');
    }


    if (response.statusCode != 200) {
      throw Exception('Failed to delete expense');
    }
  }

  Future<Map<String, double>> getGroupBalances(int groupId) async {
    final response = await http.get(
      Uri.parse('${baseUrl}/groups/$groupId/balances'),
      headers: await headers,
    );
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      Map<String, double> balances = {};
      for (var item in data) {
        balances[item['user']] = (item['balance'] as num).toDouble();
      }
      return balances;
    } else {
      throw Exception('Failed to load balances');
    }
  }

  Future<double> getTotalBalance() async {
    final response = await http.get(
      Uri.parse('${baseUrl}/user/balance'),
      headers: await headers,
    );
    
    log('Total balance response status: ${response.statusCode}');
    log('Total balance response body: ${response.body}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['balance'] as num).toDouble();
    } else {
      throw Exception('Failed to load total balance');
    }
  }

  Future<int> getTotalExpenses() async {
    final response = await http.get(
      Uri.parse('${baseUrl}/user/expenses/count'),
      headers: await headers,
    );
    
    log('Total expenses response status: ${response.statusCode}');
    log('Total expenses response body: ${response.body}');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['count'] as int;
    } else {
      throw Exception('Failed to load total expenses');
    }
  }
}
