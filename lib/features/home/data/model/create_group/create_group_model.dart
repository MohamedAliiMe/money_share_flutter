import 'package:json_annotation/json_annotation.dart';

part 'create_group_model.g.dart';

@JsonSerializable()
class CreateGroupModel {
  String? name;
  String? description;
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'member_ids')
  List<int>? members;

  CreateGroupModel({
    this.name,
    this.description,
    this.categoryId,
    this.members,
  });

  factory CreateGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGroupModelToJson(this);
}
