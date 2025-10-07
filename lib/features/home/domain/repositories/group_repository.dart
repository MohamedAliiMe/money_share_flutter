import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/data/data_list_response/base_data_list_response.dart';
import 'package:splitwise_flutter/core/data/single_item_base_response/single_item_base_response.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/core/networking/network_utils.dart';
import 'package:splitwise_flutter/features/home/domain/model/group.dart';
import 'package:splitwise_flutter/features/home/domain/service/group_service.dart';

@lazySingleton
class GroupRepository {
  final GroupService _service;

  GroupRepository(this._service);

  Future<DataState<List<GroupModel>>> getGroups() async {
    final NetworkUtils<List<GroupModel>> networkUtils = NetworkUtils();
    final response = await _service.getGroups();
    final List<GroupModel> groups = response.data ?? [];
    return DataSuccess(groups);
  }
}
