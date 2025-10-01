import 'package:json_annotation/json_annotation.dart';

part 'pivot.g.dart';

@JsonSerializable()
class PivotModel {
  @JsonKey(name: 'group_id')
  int? groupId;

  @JsonKey(name: 'user_id')
  int? userId;

  PivotModel({
    this.groupId,
    this.userId,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) =>
      _$PivotModelFromJson(json);

  Map<String, dynamic> toJson() => _$PivotModelToJson(this);
}
