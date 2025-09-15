import 'package:json_annotation/json_annotation.dart';
import 'package:splitwise_flutter/features/authentication/data/models/user_model/usermodel.dart';

part 'register_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterModel {
  UserModel? user;
  String? token;

  RegisterModel({
    this.user,
    this.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
