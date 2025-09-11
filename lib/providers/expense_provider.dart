import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';

class ExpenseProvider extends ChangeNotifier {
  final ExpenseService _expenseService;
  List<Expense> _expenses = [];
  bool _loading = false;
  String? _error;

  ExpenseProvider(this._expenseService);

  List<Expense> get expenses => _expenses;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadGroupExpenses(int groupId) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      _expenses = await _expenseService.getGroupExpenses(groupId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> createExpense({
    required int groupId,
    required int paidById,
    required String description,
    required double amount,
    required DateTime date,
    required List<Map<String, dynamic>> splits,
  }) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      final newExpense = await _expenseService.createExpense(
        groupId: groupId,
        paidById: paidById,
        description: description,
        amount: amount,
        date: date,
        splits: splits,
      );
      _expenses = [..._expenses, newExpense];
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateExpense({
    required int id,
    required String description,
    required double amount,
    required DateTime date,
    required List<Map<String, dynamic>> splits,
  }) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      final updatedExpense = await _expenseService.updateExpense(
        id: id,
        description: description,
        amount: amount,
        date: date,
        splits: splits,
      );
      _expenses = _expenses.map((e) => e.id == id ? updatedExpense : e).toList();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteExpense(int expenseId) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      await _expenseService.deleteExpense(expenseId);
      _expenses = _expenses.where((e) => e.id != expenseId).toList();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
