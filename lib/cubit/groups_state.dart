part of 'groups_cubit.dart';

@freezed
class GroupsState with _$GroupsState {
  const factory GroupsState({
    @Default(false) bool isLoading,
    String? errorMessage,
    List<GroupModel>? groups,
  }) = _GroupsState;
}
