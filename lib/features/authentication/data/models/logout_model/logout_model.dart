import 'package:json_annotation/json_annotation.dart';

part 'logout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LogoutModel {
  String? message;

  LogoutModel({
    this.message,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutModelToJson(this);
}
