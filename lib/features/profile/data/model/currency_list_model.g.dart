// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyListModel _$CurrencyListModelFromJson(Map<String, dynamic> json) =>
    CurrencyListModel(
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((e) => CurrencyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrencyListModelToJson(CurrencyListModel instance) =>
    <String, dynamic>{
      'currencies': instance.currencies,
    };
