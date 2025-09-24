import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/data/single_item_base_response/single_item_base_response.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/core/networking/network_utils.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_model/login_model.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_params/login_params.dart';
import 'package:splitwise_flutter/features/authentication/data/models/logout_model/logout_model.dart';
import 'package:splitwise_flutter/features/authentication/data/models/regester_params/regester_params.dart';
import 'package:splitwise_flutter/features/authentication/data/models/register_model/register_model.dart';
import 'package:splitwise_flutter/features/authentication/data/services/authentication_service.dart';

@lazySingleton
class AuthenticationRepository {
  final AuthenticationService _service;

  AuthenticationRepository(this._service);

  Future<DataState<LoginModel>> getLogin({
    required LoginParams loginParams,
  }) {
    final NetworkUtils<LoginModel> networkUtils =
        NetworkUtils();
    return networkUtils.handleApiResponse(_service.getLogin(
        loginParams: LoginParams(
            email: loginParams.email, password: loginParams.password)));
  }

  Future<DataState<RegisterModel>> register({
    required RegisterParams registerParams,
  }) {
    final NetworkUtils<RegisterModel> networkUtils = NetworkUtils();
    return networkUtils.handleApiResponse(_service.register(
        registerParams: RegisterParams(
      name: registerParams.name,
      email: registerParams.email,
      password: registerParams.password,
      passwordConfirmation: registerParams.passwordConfirmation,
    )));
  }

  Future<DataState<LogoutModel>> logout() {
    final NetworkUtils<LogoutModel> networkUtils = NetworkUtils();
    return networkUtils.handleApiResponse(_service.logout());
  }
}
