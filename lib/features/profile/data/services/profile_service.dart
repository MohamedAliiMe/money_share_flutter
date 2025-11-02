import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:splitwise_flutter/core/networking/api_path.dart';
import 'package:splitwise_flutter/features/profile/data/model/category_list_model.dart';
import 'package:splitwise_flutter/features/profile/data/model/country_list_model.dart';
import 'package:splitwise_flutter/features/profile/data/model/currency_list_model.dart';
import 'package:splitwise_flutter/features/profile/data/model/profile_model.dart';

part 'profile_service.g.dart';

@RestApi()
@lazySingleton
abstract class ProfileService {
  @factoryMethod
  factory ProfileService(@Named('Dio') Dio dio) => _ProfileService(dio);

  @GET(AppApiPaths.user)
  Future<ProfileModel> getProfile();

  @GET(AppApiPaths.currencies)
  Future<CurrencyListModel> getCurrencies();

  @GET(AppApiPaths.countries)
  Future<CountryListModel> getCountries();
  
  @GET(AppApiPaths.categories)
  Future<CategoryListModel> getCategories();
}
