import 'package:json_annotation/json_annotation.dart';

part 'base_data_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListBaseResponse<T> {
  List<T>? data;

  ListBaseResponse({
    this.data,
  });

  ListBaseResponse.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    if (json != null) {
      data = [];
      json['data']?.forEach((v) {
        data!.add(create(v as Map<String, dynamic>) as T);
      });
    }
  }
}
