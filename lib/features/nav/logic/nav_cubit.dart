import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:splitwise_flutter/features/nav/domain/entity/nav_entity.dart';
import 'package:splitwise_flutter/screens/activity_screen.dart';
import 'package:splitwise_flutter/screens/create_expense_screen.dart';
import 'package:splitwise_flutter/screens/create_group_screen.dart';
import 'package:splitwise_flutter/screens/home_screen.dart';
import 'package:splitwise_flutter/screens/profile_screen.dart';
import 'package:splitwise_flutter/screens/tabs/activity_tab.dart';
import 'package:splitwise_flutter/screens/tabs/groups_tab.dart';

import '../../../../../gen/assets.gen.dart';

part 'nav_state.dart';
part 'nav_cubit.freezed.dart';

@Injectable()
class NavCubit extends Cubit<NavState> {
  final _pageRefreshTimes = <int, DateTime>{};

  NavCubit() : super(NavState.initial());

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

  void addGroup(String groupName, String description) {
    if (groupName.isNotEmpty && description.isNotEmpty) {
      emit(state.copyWith(
        succses: true,
        createGroup: true,
        groupName: groupName,
        description: description,
        errorMessage: null,
      ));
      log(state.groupName.toString());
      log(state.description.toString());
    } else {
      emit(state.copyWith(
        succses: false,
        createGroup: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  void requestCreateGroup(String groupName, String description) {
    emit(state.copyWith(
      createGroupRequested: true,
      groupName: groupName,
      description: description,
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
