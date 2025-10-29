import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/data/data_list_response/base_data_list_response.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/features/home/domain/model/create_group/create_group_model.dart';
import 'package:splitwise_flutter/features/home/domain/model/delete_group/delete_group_model.dart';
import 'package:splitwise_flutter/features/home/domain/model/groups/group.dart';
import 'package:splitwise_flutter/features/home/domain/model/update_groups/update_groups_model.dart';
import 'package:splitwise_flutter/features/home/domain/repositories/group_repository.dart';

part 'groups_state.dart';
part 'groups_cubit.freezed.dart';

@Injectable()
class GroupsCubit extends Cubit<GroupsState> {
  final GroupRepository _groupRepository;
  GroupsCubit(this._groupRepository) : super(GroupsState());

  Future<void> fetchGroups() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final DataState<List<GroupModel>> dataState =
        await _groupRepository.getGroups();
    if (dataState is DataSuccess) {
      emit(state.copyWith(
        isLoading: false,
        groups: dataState.data,
      ));
    } else {
      emit(state.copyWith(
          isLoading: false, errorMessage: dataState.error ?? "Unknown error"));
    }
  }

  Future<void> deleteGroup(int groupId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final DataState<DeleteGroupModel> dataState =
        await _groupRepository.deleteGroup(groupId);
    if (dataState is DataSuccess) {
      final updatedGroups =
          state.groups?.where((group) => group.id != groupId).toList();
      emit(state.copyWith(
        isLoading: false,
        groups: updatedGroups,
        deletedGroupId: groupId,
        deleteGroupModel: dataState.data,
        successMessage: dataState.data?.message,
      ));
    } else {
      emit(state.copyWith(
          isLoading: false,
          errorMessage: dataState.data?.message ?? "Unknown error"));
    }
  }

  Future<void> updateGroup(
      int groupId, UpdateGroupsModel updateGroupsModel) async {
    emit(state.copyWith(
        isLoading: true, errorMessage: null, successMessage: null));

    final DataState<UpdateGroupsModel> dataState =
        await _groupRepository.updateGroup(groupId, updateGroupsModel);

    if (dataState is DataSuccess) {
      await fetchGroups();

      emit(state.copyWith(
        isLoading: false,
        updateGroupsModel: dataState.data,
        successMessage: "Group updated successfully",
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: dataState.error ?? "Unknown error",
      ));
    }
  }
}
