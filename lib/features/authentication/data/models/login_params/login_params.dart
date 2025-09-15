import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_params.g.dart';

@JsonSerializable(includeIfNull: true)
class LoginParams {
  String? email;
  String? password;

  LoginParams({
    this.email,
    this.password,
  });

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}
