import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/home/logic/groups_cubit.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/nav/logic/nav_cubit.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/data/model/groups/group.dart';
import 'package:splitwise_flutter/features/home/data/model/groups/user.dart';
import 'package:splitwise_flutter/features/home/pages/group_details_screen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import 'package:splitwise_flutter/features/home/widget/add_member_dialog.dart';
import 'package:splitwise_flutter/features/home/widget/searsh_friendes_dialog_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GroupsCubit _groupsCubit = getIt<GroupsCubit>();
  Widget? _currentBody;
  bool _isHomePage = true;

  String? _selectedGroupName;
  String? _selectedGroupIcon;

  @override
  void initState() {
    super.initState();
    _groupsCubit.fetchGroups();
  }

  void _showGroupDetails(GroupModel group) {
    context.read<NavCubit>().updateAppBarForDetails(
          title: group.name ?? "",
          icon: Assets.images.house,
        );
    context.read<NavCubit>().setSelectedGroup(group);

    setState(() {
      _currentBody = GroupDetailsScreen(group: group);
      _isHomePage = false;
    });
  }

  void _showGroupsList() {
    setState(() {
      _currentBody = _buildGroupsList();
      _isHomePage = true;
      _selectedGroupName = null;
      _selectedGroupIcon = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AllColors.globalAppColor,
      onRefresh: () async {
        await _groupsCubit.fetchGroups();
      },
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (!_isHomePage) {
              _showGroupsList();
              context.read<NavCubit>().resetAppBarToHome();
              await _groupsCubit.fetchGroups();

              return false;
            }
            return true;
          },
          child: _currentBody ?? _buildGroupsList(),
        ),
      ),
    );
  }

  Widget _buildGroupsList() {
    return BlocBuilder<GroupsCubit, GroupsState>(
      bloc: _groupsCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
              child:
                  CircularProgressIndicator(color: AllColors.globalAppColor));
        }
        if (state.errorMessage != null) {
          return Center(child: Text(state.errorMessage!));
        }

        final groups = state.groups ?? [];

        if (groups.isEmpty) {
          return _buildEmptyState(context);
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.groups.tr(), style: tr20),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(Assets.images.filter)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];
                  return GestureDetector(
                    onTap: () => _showGroupDetails(group),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AllColors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AllColors.grey.withOpacity(0.03),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor:
                                AllColors.globalAppColor.withOpacity(0.7),
                            child: group.categoryId == 1
                                ? SvgPicture.asset(
                                    Assets.images.trip,
                                    width: 24.w,
                                    height: 24.h,
                                    color: AllColors.white,
                                  )
                                : group.categoryId == 2
                                    ? SvgPicture.asset(
                                        Assets.images.friends,
                                        width: 24.w,
                                        height: 24.h,
                                        color: AllColors.white,
                                      )
                                    : group.categoryId == 3
                                        ? SvgPicture.asset(
                                            Assets.images.heart,
                                            width: 24.w,
                                            height: 24.h,
                                          )
                                        : group.categoryId == 4
                                            ? SvgPicture.asset(
                                                Assets.images.other,
                                                width: 24.w,
                                                height: 24.h,
                                                color: AllColors.white,
                                              )
                                            : SizedBox.shrink(),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        group.name?.toString() ?? '',
                                        style: tr16,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        group.monthlyExpenses?.toString() ?? '',
                                        style: tr13,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    if (group.members != null)
                                      SvgPicture.asset(
                                        Assets.images.people,
                                        width: 16.w,
                                        height: 16.h,
                                      ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "${group.members?.length.toString()} ${LocaleKeys.members.tr()}",
                                      style:
                                          tr13.copyWith(color: AllColors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.images.clockRefresh,
                                      width: 16.w,
                                      height: 16.h,
                                      color: AllColors.black,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(group.totalSpent?.toString() ?? '',
                                        style: tr13.copyWith(
                                            color: AllColors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector buildCustomButton({
    required String title,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onTap,
    required String iconPath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor, width: 1.w)),
        alignment: Alignment.center,
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            12.w.horizontalSpace,
            Text(
              title,
              style: tr13.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: LocaleKeys.readyTo.tr(),
                  style: tr13.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: LocaleKeys.splitsmart.tr(),
                      style: tr13.copyWith(
                        color: AllColors.globalAppColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: "\n${LocaleKeys.createFirstGroup.tr()}"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              AppButton(
                text: LocaleKeys.addGroup.tr(),
                color: AllColors.globalAppColor,
                textColor: AllColors.white,
                onPressed: () {
                  context.read<NavCubit>().changePage(2);
                },
                width: 182.w,
              ),
            ],
          )
        ],
      ),
    );
  }
}
