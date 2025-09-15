import 'package:freezed_annotation/freezed_annotation.dart';

part 'usermodel.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  int? id;
  String? name;
  String? email;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  List<GroupModel>? groups;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.groups,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GroupModel {
  int? id;
  String? name;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'total_spent')
  String? totalSpent;
  @JsonKey(name: 'total_expenses')
  int? totalExpenses;
  @JsonKey(name: 'monthly_expenses')
  List<Map<String, dynamic>>? monthlyExpenses;
  @JsonKey(name: 'member_stats')
  List<Map<String, dynamic>>? memberStats;
  PivotModel? pivot;

  GroupModel({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.totalSpent,
    this.totalExpenses,
    this.monthlyExpenses,
    this.memberStats,
    this.pivot,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}

@JsonSerializable()
class PivotModel {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'group_id')
  int? groupId;

  PivotModel({
    this.userId,
    this.groupId,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) =>
      _$PivotModelFromJson(json);

  Map<String, dynamic> toJson() => _$PivotModelToJson(this);
}
