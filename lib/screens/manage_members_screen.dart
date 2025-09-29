import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/screens/group_details_screen.dart';
import '../models/group.dart';
import '../models/user.dart';

class ManageMembersScreen extends StatefulWidget {
  final Group group;

  const ManageMembersScreen({
    super.key,
    required this.group,
  });

  @override
  State<ManageMembersScreen> createState() => _ManageMembersScreenState();
}

class _ManageMembersScreenState extends State<ManageMembersScreen> {
  bool _isLoading = false;

  final List<User> _dummyMembers = [
    User(id: 1, name: "You", email: "mohamed@gmail.com"),
    User(id: 2, name: "Ahmed", email: "ahmed@gmail.com"),
    User(id: 3, name: "Ali", email: "ali@gmail.com"),
    User(id: 4, name: "Hassan", email: "hassan@gmail.com"),
  ];

  final List<User> _dummyFriends = [
    User(id: 5, name: "Omar", email: "omar@gmail.com"),
    User(id: 6, name: "Sara", email: "sara@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                buildHeader("Charts",
                    // look figma with conntact api => (replace name)
                    actionText: "Invite",
                    onAction: () {},
                    color: AllColors.globalAppColor,
                    colorText: AllColors.white,
                    hasIcon: true,
                    assetName: Assets.images.plus),
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
                          child: Text(
                            member.name[0],
                            style: tr20,
                          ),
                        ),
                        title: Text(
                          member.name,
                          style: tr20,
                        ),
                        subtitle: Text(
                          member.email,
                          style: tr13.copyWith(
                              color: AllColors.grey.withOpacity(0.9)),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            AppAlertDialog.showSuccessBar(
                                message: "Removed ${member.name}");
                          },
                          child: SvgPicture.asset(Assets.images.remove),
                        )),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Text(
                    "Friends",
                    style: tr20,
                  ),
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
                          child: Text(
                            friend.name[0],
                            style: tr20,
                          ),
                        ),
                        title: Text(
                          friend.name,
                          style: tr20,
                        ),
                        subtitle: Text(
                          friend.email,
                          style: tr13.copyWith(
                              color: AllColors.grey.withOpacity(0.9)),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            AppAlertDialog.showSuccessBar(
                                message: "Added ${friend.name} to members");
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                AllColors.globalAppColor.withOpacity(0.1),
                            child: SvgPicture.asset(
                              Assets.images.plus,
                              color: AllColors.globalAppColor,
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
    );
  }
}
