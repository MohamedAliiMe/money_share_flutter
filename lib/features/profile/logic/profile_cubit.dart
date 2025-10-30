import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/features/profile/data/model/profile_model.dart';
import 'package:splitwise_flutter/features/profile/data/repositories/profile_repositories.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

@Injectable()
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepositories _repositories;

  ProfileCubit(this._repositories) : super(ProfileState());

  Future<void> getProfile() async {
    emit(state.copyWith(isLoading: true));
    final DataState<ProfileModel> dataState = await _repositories.getProfile();
    if (dataState is DataSuccess) {
      emit(state.copyWith(
        isLoading: false,
        profile: dataState.data,
      ));
    } else {
      emit(state.copyWith(
          isLoading: false, errorMessage: dataState.error ?? "Unknown error"));
    }
  }
}
