// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBaseResponse<T> _$ListBaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ListBaseResponse<T>(
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ListBaseResponseToJson<T>(
  ListBaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data?.map(toJsonT).toList(),
    };
