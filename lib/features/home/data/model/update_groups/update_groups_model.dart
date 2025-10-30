import 'package:json_annotation/json_annotation.dart';

part 'update_groups_model.g.dart';

@JsonSerializable()
class UpdateGroupsModel {
  String? name;
  String? description;

  UpdateGroupsModel({
    this.name,
    this.description,
  });

  factory UpdateGroupsModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateGroupsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateGroupsModelToJson(this);
}
