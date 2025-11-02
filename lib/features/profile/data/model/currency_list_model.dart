import 'package:json_annotation/json_annotation.dart';
import 'currency_model.dart';

part 'currency_list_model.g.dart';

@JsonSerializable()
class CurrencyListModel {
  final List<CurrencyModel>? currencies;

  CurrencyListModel({this.currencies});

  factory CurrencyListModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyListModelToJson(this);
}
