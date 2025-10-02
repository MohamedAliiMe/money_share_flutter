class ActivityModel {
  final int id;
  final String description;
  final String type;
  final DateTime createdAt;
  final double amount;
  final int groupId;
  final String groupName;
  final int userId;
  final String userName;

  ActivityModel({
    required this.id,
    required this.description,
    required this.type,
    required this.createdAt,
    required this.amount,
    required this.groupId,
    required this.groupName,
    required this.userId,
    required this.userName,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      amount: double.parse(json['amount'].toString()),
      groupId: json['group_id'],
      groupName: json['group_name'],
      userId: json['user_id'],
      userName: json['user_name'],
    );
  }
}
