import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/constants/app_string_constants.dart';
import 'package:splitwise_flutter/core/data/single_item_base_response/single_item_base_response.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/core/utilities/app_data_storage.dart';
import 'package:splitwise_flutter/core/utilities/static_data.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_model/login_model.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_params/login_params.dart';
import 'package:splitwise_flutter/features/authentication/data/models/regester_params/regester_params.dart';
import 'package:splitwise_flutter/features/authentication/data/models/register_model/register_model.dart';
import 'package:splitwise_flutter/features/authentication/data/repositories/authentication_repository.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

@Injectable()
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  final DataStorage _dataStorage = getIt<DataStorage>();

  AuthenticationCubit(this._authenticationRepository)
      : super(const AuthenticationState());

  Future<void> getLogin({
    required LoginParams loginParams,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      failedState: false,
      errorMessage: null,
      loginErrorMessage: null,
      successMessage: null,
      failedLoginState: false,
    ));

    final DataState<SingleItemBaseResponse<LoginModel>> dataState =
        await _authenticationRepository.getLogin(loginParams: loginParams);

    if (dataState is DataSuccess) {
      final loginData = dataState.data!.data!;
      final token = loginData.token;

      emit(state.copyWith(
        isLoading: false,
        failedState: false,
        getLogin: loginData,
        successMessage: dataState.data!.message,
        failedLoginState: false,
        errorMessage: null,
        loginErrorMessage: null,
      ));

      await _dataStorage.saveData(AppStringConstants.userAccessToken, token);
      StaticData.isAuth = false;
    } else {
      emit(state.copyWith(
        isLoading: false,
        successMessage: null,
        loginErrorMessage: dataState.error,
        errorMessage: null,
        failedLoginState: true,
        failedState: true,
      ));
    }
  }

  Future<void> register({
    required RegisterParams registerParams,
  }) async {
    emit(state.copyWith(
      isLoading: true,
      failedState: false,
      errorMessage: null,
      successMessage: null,
    ));
    final DataState<SingleItemBaseResponse<RegisterModel>> dataState =
        await _authenticationRepository.register(
            registerParams: registerParams);
    if (dataState is DataSuccess) {
      emit(state.copyWith(
        isLoading: false,
        failedState: true,
        register: dataState.data!.data,
        successMessage: dataState.data?.message,
        errorMessage: null,
      ));
      await _dataStorage.saveData(
          AppStringConstants.userAccessToken, dataState.data!.data!.token);
      StaticData.isAuth = false;

      log('User access token saved: ${dataState.data!.data!.token}');
    } else {
      log('Error retrieving token: ${dataState.error}');
      emit(state.copyWith(
        isLoading: false,
        successMessage: null,
        errorMessage: dataState.error,
        failedState: false,
      ));
    }
  }

  Future<String?> getCustomerAccessToken() async {
    try {
      final token =
          await _dataStorage.getData(AppStringConstants.userAccessToken);
      emit(state.copyWith(userAccessToken: token));
      return token;
    } catch (e) {
      log('Error retrieving token: $e');
      return null;
    }
  }
}
