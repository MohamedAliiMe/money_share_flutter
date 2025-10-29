import 'package:json_annotation/json_annotation.dart';
import 'package:splitwise_flutter/features/home/domain/model/groups/pivot.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  int? id;
  String? name;
  String? email;

  @JsonKey(name: 'email_verified_at')
  String? emailVerifiedAt;

  String? phone;

  @JsonKey(name: 'currency_id')
  int? currencyId;

  @JsonKey(name: 'country_id')
  int? countryId;

  String? language;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  PivotModel? pivot;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.currencyId,
    this.countryId,
    this.language,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
