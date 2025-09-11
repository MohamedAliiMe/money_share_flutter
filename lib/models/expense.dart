import 'user.dart';
import 'expense_split.dart';

class Expense {
  final int id;
  final int groupId;
  final User paidBy;
  final String description;
  final double amount;
  final DateTime date;
  final List<ExpenseSplit> splits;

  Expense({
    required this.id,
    required this.groupId,
    required this.paidBy,
    required this.description,
    required this.amount,
    required this.date,
    required this.splits,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      groupId: json['group_id'],
      paidBy: User.fromJson(json['paid_by']),
      description: json['description'],
      amount: double.parse(json['amount'].toString()),
      date: DateTime.parse(json['date']),
      splits: (json['splits'] as List)
          .map((split) => ExpenseSplit.fromJson(split))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'paid_by': paidBy.toJson(),
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'splits': splits.map((split) => split.toJson()).toList(),
    };
  }
}
