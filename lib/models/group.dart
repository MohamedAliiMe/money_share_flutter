import 'user.dart';

class Group {
  final double totalSpent;
  final int totalExpenses;
  final List<Map<String, dynamic>>? monthlyExpenses;
  final List<Map<String, dynamic>>? memberStats;
  final int id;
  final String name;
  final String? description;
  final List<User> members;

  Group({
    required this.id,
    required this.name,
    required this.members,
    this.description,
    this.totalSpent = 0,
    this.totalExpenses = 0,
    this.monthlyExpenses,
    this.memberStats,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    var membersList = json['members'] as List<dynamic>?;
    return Group(
      id: json['id'],
      name: json['name'],
      description: json['description'] as String?,
      totalSpent: json['total_spent'] is String 
          ? double.parse(json['total_spent']) 
          : (json['total_spent'] as num?)?.toDouble() ?? 0,
      totalExpenses: json['total_expenses'] as int? ?? 0,
      monthlyExpenses: json['monthly_expenses'] != null
          ? List<Map<String, dynamic>>.from(json['monthly_expenses'] as List)
          : null,
      memberStats: json['member_stats'] != null
          ? List<Map<String, dynamic>>.from(json['member_stats'] as List)
          : null,
      members: membersList != null
          ? membersList.map((x) => User.fromJson(x as Map<String, dynamic>)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'total_spent': totalSpent,
      'members': members.map((user) => user.toJson()).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Group &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
