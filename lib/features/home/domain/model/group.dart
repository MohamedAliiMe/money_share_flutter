import 'package:json_annotation/json_annotation.dart';
import 'package:splitwise_flutter/features/home/domain/model/pivot.dart';
import 'user.dart';

part 'group.g.dart';

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
  List<dynamic>? monthlyExpenses;

  @JsonKey(name: 'member_stats')
  List<dynamic>? memberStats;

  List<UserModel>? members;
  PivotModel? pivot;

  GroupModel({
    this.id,
    this.name,
    this.pivot,
    this.createdAt,
    this.updatedAt,
    this.totalSpent,
    this.totalExpenses = 0,
    this.monthlyExpenses,
    this.memberStats,
    this.members = const [],
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
