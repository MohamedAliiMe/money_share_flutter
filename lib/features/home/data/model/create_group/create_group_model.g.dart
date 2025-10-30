// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupModel _$CreateGroupModelFromJson(Map<String, dynamic> json) =>
    CreateGroupModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      members: (json['member_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CreateGroupModelToJson(CreateGroupModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category_id': instance.categoryId,
      'member_ids': instance.members,
    };
