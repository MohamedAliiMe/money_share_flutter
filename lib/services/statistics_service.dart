import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import '../core/utils/api_constants.dart';
import 'dart:developer' as developer;

class StatisticsService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<Map<String, dynamic>> getGroupStatistics(int groupId) async {
    developer
        .log('Statistics URL: $baseUrl/groups/$groupId/statistics');
    final response = await http.get(
      Uri.parse('$baseUrl/groups/$groupId/statistics'),
      headers: await ApiConstants.getHeaders(),
    );
    developer.log('Statistics response status: ${response.statusCode}');
    developer.log('Statistics response body: ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load group statistics');
    }
  }

  Future<List<Map<String, dynamic>>> getMonthlyExpenses(int groupId) async {
    developer
        .log('Monthly expenses URL: $baseUrl/groups/$groupId/monthly-expenses');
    final response = await http.get(
      Uri.parse('$baseUrl/groups/$groupId/monthly-expenses'),
      headers: await ApiConstants.getHeaders(),
    );
    developer.log('Monthly expenses response status: ${response.statusCode}');
    developer.log('Monthly expenses response body: ${response.body}');
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load monthly expenses');
    }
  }

  Future<List<int>> exportToExcel(int groupId) async {
    developer
        .log('Export URL: $baseUrl/groups/$groupId/export');
    final response = await http.get(
      Uri.parse('$baseUrl/groups/$groupId/export'),
      headers: await ApiConstants.getHeaders(),
    );
    developer.log('Export response status: ${response.statusCode}');
    developer.log('Export response body: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to export data');
    }

    final data = json.decode(response.body);
    final stats = data['stats'];
    final monthlyExpenses =
        List<Map<String, dynamic>>.from(data['monthly_expenses']);

    var excel = Excel.createExcel();

    // Summary Sheet
    var summarySheet = excel['Summary'];
    summarySheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
      ..value = 'Group Statistics'
      ..cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
      );

    summarySheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 2))
      ..value = 'Total Spent'
      ..cellStyle = CellStyle(bold: true);
    summarySheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 2))
        .value = stats['total_spent'];

    summarySheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 3))
      ..value = 'Number of Expenses'
      ..cellStyle = CellStyle(bold: true);
    summarySheet
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 3))
        .value = stats['total_expenses'];

    // Monthly Expenses Sheet
    var monthlySheet = excel['Monthly Expenses'];
    monthlySheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
      ..value = 'Month'
      ..cellStyle = CellStyle(bold: true);
    monthlySheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
      ..value = 'Total Amount'
      ..cellStyle = CellStyle(bold: true);

    int row = 1;
    for (var expense in monthlyExpenses) {
      monthlySheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = expense['month'];
      monthlySheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
          .value = expense['total'];
      row++;
    }

    // Member Expenses Sheet
    var memberSheet = excel['Member Expenses'];
    memberSheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
      ..value = 'Member'
      ..cellStyle = CellStyle(bold: true);
    memberSheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
      ..value = 'Total Paid'
      ..cellStyle = CellStyle(bold: true);
    memberSheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
      ..value = 'Total Share'
      ..cellStyle = CellStyle(bold: true);
    memberSheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
      ..value = 'Balance'
      ..cellStyle = CellStyle(bold: true);

    row = 1;
    for (var member in (stats['member_stats'] as List)) {
      memberSheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = member['name'];
      memberSheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
          .value = member['total_paid'];
      memberSheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
          .value = member['total_share'];
      memberSheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
          .value = member['balance'];
      row++;
    }

    return excel.encode()!;
  }
}
