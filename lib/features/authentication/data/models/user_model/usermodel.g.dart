// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'groups': instance.groups?.map((e) => e.toJson()).toList(),
    };

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      totalSpent: json['total_spent'] as String?,
      totalExpenses: (json['total_expenses'] as num?)?.toInt(),
      monthlyExpenses: (json['monthly_expenses'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      memberStats: (json['member_stats'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      pivot: json['pivot'] == null
          ? null
          : PivotModel.fromJson(json['pivot'] as Map<String, dynamic>),
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
      'pivot': instance.pivot?.toJson(),
    };

PivotModel _$PivotModelFromJson(Map<String, dynamic> json) => PivotModel(
      userId: (json['user_id'] as num?)?.toInt(),
      groupId: (json['group_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PivotModelToJson(PivotModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'group_id': instance.groupId,
    };
