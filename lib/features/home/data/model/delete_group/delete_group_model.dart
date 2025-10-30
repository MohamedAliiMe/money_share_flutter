import 'package:json_annotation/json_annotation.dart';

part 'delete_group_model.g.dart';

@JsonSerializable()
class DeleteGroupModel {
  final String message;

  DeleteGroupModel({required this.message});

  factory DeleteGroupModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteGroupModelToJson(this);
}
