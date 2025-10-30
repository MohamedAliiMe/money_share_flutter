import 'package:json_annotation/json_annotation.dart';
import 'package:splitwise_flutter/features/home/data/model/groups/group.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  UserModel? user;

  ProfileModel({this.user});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

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
  List<GroupModel>? groups;
  dynamic country;
  dynamic currency;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.currencyId,
    this.countryId,
    this.language,
    this.groups,
    this.country,
    this.currency,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
