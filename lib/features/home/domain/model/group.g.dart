// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      pivot: json['pivot'] == null
          ? null
          : PivotModel.fromJson(json['pivot'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      totalSpent: json['total_spent'] as String?,
      totalExpenses: (json['total_expenses'] as num?)?.toInt() ?? 0,
      monthlyExpenses: json['monthly_expenses'] as List<dynamic>?,
      memberStats: json['member_stats'] as List<dynamic>?,
      members: (json['members'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'total_spent': instance.totalSpent,
      'total_expenses': instance.totalExpenses,
      'monthly_expenses': instance.monthlyExpenses,
      'member_stats': instance.memberStats,
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'pivot': instance.pivot?.toJson(),
    };
