import 'user.dart';

class ExpenseSplit {
  final int id;
  final int expenseId;
  final UserModel user;
  final double amount;

  ExpenseSplit({
    required this.id,
    required this.expenseId,
    required this.user,
    required this.amount,
  });

  factory ExpenseSplit.fromJson(Map<String, dynamic> json) {
    return ExpenseSplit(
      id: json['id'],
      expenseId: json['expense_id'],
      user: UserModel.fromJson(json['user']),
      amount: double.parse(json['amount'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'expense_id': expenseId,
      'user': user.toJson(),
      'amount': amount,
    };
  }
}
