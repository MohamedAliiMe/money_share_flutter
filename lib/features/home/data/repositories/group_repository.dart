import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/data/data_list_response/base_data_list_response.dart';
import 'package:splitwise_flutter/core/data/single_item_base_response/single_item_base_response.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/core/networking/network_utils.dart';
import 'package:splitwise_flutter/features/home/data/model/create_group/create_group_model.dart';
import 'package:splitwise_flutter/features/home/data/model/delete_group/delete_group_model.dart';
import 'package:splitwise_flutter/features/home/data/model/groups/group.dart';
import 'package:splitwise_flutter/features/home/data/model/update_groups/update_groups_model.dart';
import 'package:splitwise_flutter/features/home/data/service/group_service.dart';

@lazySingleton
class GroupRepository {
  final GroupService _service;

  GroupRepository(this._service);

  Future<DataState<List<GroupModel>>> getGroups() async {
    // final NetworkUtils<List<GroupModel>> networkUtils = NetworkUtils();
    final response = await _service.getGroups();
    final List<GroupModel> groups = response.data ?? [];
    return DataSuccess(groups);
  }

  Future<DataState<CreateGroupModel>> createGroup(
      CreateGroupModel createGroupModel) async {
    // final NetworkUtils<CreateGroupModel> networkUtils = NetworkUtils();
    final response = await _service.createGroup(body: createGroupModel);
    final CreateGroupModel group = response.data;
    return DataSuccess(group);
  }

  Future<DataState<DeleteGroupModel>> deleteGroup(int groupId) async {
    final response = await _service.deleteGroup(groupId: groupId);
    return DataSuccess(response.data);
  }

  Future<DataState<UpdateGroupsModel>> updateGroup(
      int groupId, UpdateGroupsModel updateGroupsModel) async {
    final response =
        await _service.updateGroup(groupId: groupId, body: updateGroupsModel);
    return DataSuccess(response.data);
  }
}
