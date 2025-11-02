import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/features/profile/data/model/category_list_model.dart';
import 'package:splitwise_flutter/features/profile/data/model/currency_list_model.dart';
import 'package:splitwise_flutter/features/profile/data/model/profile_model.dart';
import 'package:splitwise_flutter/features/profile/data/model/country_list_model.dart';
import 'package:splitwise_flutter/features/profile/data/services/profile_service.dart';

@lazySingleton
class ProfileRepositories {
  final ProfileService _service;

  ProfileRepositories(this._service);

  Future<DataState<ProfileModel>> getProfile() async {
    final response = await _service.getProfile();
    final ProfileModel profile = response;

    return DataSuccess(profile);
  }

  Future<DataState<CurrencyListModel>> getCurrencies() async {
    final response = await _service.getCurrencies();
    final CurrencyListModel currencies = response;

    return DataSuccess(currencies);
  }

  Future<DataState<CountryListModel>> getCountries() async {
    final response = await _service.getCountries();
    final CountryListModel countries = response;

    return DataSuccess(countries);
  }

  Future<DataState<CategoryListModel>> getCategories() async {
    final response = await _service.getCategories();
    final CategoryListModel categories = response;

    return DataSuccess(categories);
  }
}
