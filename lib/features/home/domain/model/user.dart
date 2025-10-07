import 'package:json_annotation/json_annotation.dart';
import 'package:splitwise_flutter/features/home/domain/model/pivot.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? email;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;
  PivotModel? pivot;

  UserModel({
    this.id,
    this.pivot,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
