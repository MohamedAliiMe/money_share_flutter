import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/data/data_list_response/base_data_list_response.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/features/home/domain/model/group.dart';
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
}
