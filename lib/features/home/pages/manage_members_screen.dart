import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/pages/group_details_screen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import '../domain/model/group.dart';
import '../domain/model/user.dart';

class ManageMembersScreen extends StatefulWidget {
  final GroupModel group;

  const ManageMembersScreen({
    super.key,
    required this.group,
  });

  @override
  State<ManageMembersScreen> createState() => _ManageMembersScreenState();
}

class _ManageMembersScreenState extends State<ManageMembersScreen> {
  bool _isLoading = false;

  final List<UserModel> _dummyMembers = [
    UserModel(id: 1, name: "You", email: "mohamed@gmail.com"),
    UserModel(id: 2, name: "Ahmed", email: "ahmed@gmail.com"),
    UserModel(id: 3, name: "Ali", email: "ali@gmail.com"),
    UserModel(id: 4, name: "Hassan", email: "hassan@gmail.com"),
  ];

  final List<UserModel> _dummyFriends = [
    UserModel(id: 5, name: "Omar", email: "omar@gmail.com"),
    UserModel(id: 6, name: "Sara", email: "sara@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                buildHeader(
                  LocaleKeys.membersChart.tr(),
                  actionText: LocaleKeys.invite.tr(),
                  onAction: () {},
                  color: AllColors.globalAppColor,
                  colorText: AllColors.white,
                  hasIcon: true,
                  assetName: Assets.images.plus,
                ),
                SizedBox(height: 16.h),
                ..._dummyMembers.map(
                  (member) => Card(
                    elevation: 0,
                    color: AllColors.grey.withOpacity(0.1),
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            AllColors.globalAppColor.withOpacity(0.2),
                        child: Text(member.name?[0] ?? '', style: tr20),
                      ),
                      title: Text(member.name ?? '', style: tr20),
                      subtitle: Text(
                        member.email ?? '',
                        style: tr13.copyWith(
                          color: AllColors.grey.withOpacity(0.9),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          AppAlertDialog.showSuccessBar(
                            message:
                                "${LocaleKeys.removed.tr()} ${member.name}",
                          );
                        },
                        child: SvgPicture.asset(Assets.images.remove),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Divider(
                  endIndent: 16.w,
                  indent: 16.w,
                  color: AllColors.grey.withOpacity(0.5),
                  height: 0,
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(LocaleKeys.friends.tr(), style: tr20),
                ),
                SizedBox(height: 12.h),
                ..._dummyFriends.map(
                  (friend) => Card(
                    elevation: 0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            AllColors.globalAppColor.withOpacity(0.2),
                        child: Text(friend.name?[0] ?? '', style: tr20),
                      ),
                      title: Text(friend.name ?? '', style: tr20),
                      subtitle: Text(
                        friend.email ?? '',
                        style: tr13.copyWith(
                          color: AllColors.grey.withOpacity(0.9),
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          AppAlertDialog.showSuccessBar(
                            message:
                                "${LocaleKeys.added.tr()} ${friend.name} ${LocaleKeys.toMembers.tr()}",
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              AllColors.globalAppColor.withOpacity(0.1),
                          child: SvgPicture.asset(
                            Assets.images.plus,
                            color: AllColors.globalAppColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
