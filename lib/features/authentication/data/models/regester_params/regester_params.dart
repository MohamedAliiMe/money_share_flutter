import 'package:freezed_annotation/freezed_annotation.dart';

part 'regester_params.g.dart';

@JsonSerializable(includeIfNull: true)
class RegisterParams {
  String? name;
  String? email;
  String? password;
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;

  RegisterParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  factory RegisterParams.fromJson(Map<String, dynamic> json) =>
      _$RegisterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}
