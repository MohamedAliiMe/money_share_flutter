// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotModel _$PivotModelFromJson(Map<String, dynamic> json) => PivotModel(
      groupId: (json['group_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PivotModelToJson(PivotModel instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'user_id': instance.userId,
    };
