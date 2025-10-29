import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/core/networking/data_state.dart';
import 'package:splitwise_flutter/features/home/domain/model/create_group/create_group_model.dart';
import 'package:splitwise_flutter/features/home/domain/model/groups/group.dart';
import 'package:splitwise_flutter/features/home/domain/repositories/group_repository.dart';
import 'package:splitwise_flutter/features/nav/domain/entity/nav_entity.dart';
import 'package:splitwise_flutter/features/activity/pages/activity_screen.dart';
import 'package:splitwise_flutter/features/home/pages/create_expense_screen.dart';
import 'package:splitwise_flutter/features/home/pages/create_group_screen.dart';
import 'package:splitwise_flutter/features/home/pages/home_screen.dart';
import 'package:splitwise_flutter/features/profile/pages/profile_screen.dart';
import 'package:splitwise_flutter/features/friends/pages/activity_tab.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

import '../../../../../gen/assets.gen.dart';

part 'nav_state.dart';
part 'nav_cubit.freezed.dart';

@Injectable()
class NavCubit extends Cubit<NavState> {
  final _pageRefreshTimes = <int, DateTime>{};
  final GroupRepository _groupRepository;

  NavCubit(this._groupRepository) : super(NavState.initial());

  void changePage(int index) {
    if (index < 0 || index >= state.navPages.length) return;
    if (state.currentIndex == index) return;

    final newPages = List<Widget>.from(state.pages);
    final now = DateTime.now();

    const immediateRefreshPages = {0, 3};
    const delayedRefreshPages = {
      1: Duration(seconds: 30),
      2: Duration(seconds: 30),
    };

    if (immediateRefreshPages.contains(index)) {
      newPages[index] = _createPageWithNewKey(index);
    } else if (delayedRefreshPages.containsKey(index)) {
      final lastRefresh = _pageRefreshTimes[index];
      final refreshInterval = delayedRefreshPages[index]!;

      if (lastRefresh == null ||
          now.difference(lastRefresh) > refreshInterval) {
        newPages[index] = _createPageWithNewKey(index);
        _pageRefreshTimes[index] = now;
      }
    }

    emit(state.copyWith(
      currentIndex: index,
      pages: newPages,
      currentPage: state.navPages[index],
    ));
  }

  Widget _createPageWithNewKey(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ActivityTab();
      case 2:
        return CreateGroupScreen();
      case 3:
        return const ActivityTab();
      case 4:
        return const ProfileScreen();
      default:
        return state.pages[index];
    }
  }

  void setSelectedGroup(GroupModel group) {
    emit(state.copyWith(selectedGroup: group));
  }

  void addGroup(CreateGroupModel createGroupModel) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final DataState<CreateGroupModel> dataState =
        await _groupRepository.createGroup(createGroupModel);
    if (dataState is DataSuccess) {
      emit(state.copyWith(
        isLoading: false,
        createdGroup: dataState.data,
        succses: true,
        createGroup: true,
      ));
    } else {
      emit(state.copyWith(
          isLoading: false, errorMessage: dataState.error ?? "Unknown error"));
    }
  }

  void requestCreateGroup(CreateGroupModel createGroupModel) {
    emit(state.copyWith(
      createGroupRequested: true,
      createdGroup: createGroupModel,
    ));
  }

  void resetCreateGroupRequest() {
    emit(state.copyWith(createGroupRequested: false));
  }

  void updateAppBarForDetails({required String title, String? icon}) {
    emit(state.copyWith(
      appBarTitle: title,
      appBarIcon: icon,
      isDetailsPage: true,
    ));
  }

  void resetAppBarToHome() {
    emit(state.copyWith(
      appBarTitle: "Splitsmart",
      appBarIcon: null,
      isDetailsPage: false,
    ));
  }
}
