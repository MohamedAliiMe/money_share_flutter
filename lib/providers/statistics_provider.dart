import 'package:flutter/foundation.dart';
import '../services/statistics_service.dart';

class StatisticsProvider with ChangeNotifier {
  final StatisticsService _statisticsService;
  Map<String, dynamic>? _groupStats;
  List<Map<String, dynamic>>? _monthlyExpenses;
  bool _isLoading = false;
  String? _error;

  StatisticsProvider(this._statisticsService);

  Map<String, dynamic>? get groupStats => _groupStats;
  List<Map<String, dynamic>>? get monthlyExpenses => _monthlyExpenses;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadGroupStatistics(int groupId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _groupStats = await _statisticsService.getGroupStatistics(groupId);
      _monthlyExpenses = await _statisticsService.getMonthlyExpenses(groupId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<int>> exportToExcel(int groupId) async {
    try {
      return await _statisticsService.exportToExcel(groupId);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
