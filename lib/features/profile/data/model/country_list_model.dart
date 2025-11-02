import 'package:json_annotation/json_annotation.dart';
import 'country_model.dart';

part 'country_list_model.g.dart';

@JsonSerializable()
class CountryListModel {
  final List<CountryModel>? countries;

  CountryListModel({this.countries});

  factory CountryListModel.fromJson(Map<String, dynamic> json) =>
      _$CountryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryListModelToJson(this);
}
