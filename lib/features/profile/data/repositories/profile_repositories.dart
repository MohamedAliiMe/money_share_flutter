import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/features/profile/data/model/profile_model.dart';
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
}
