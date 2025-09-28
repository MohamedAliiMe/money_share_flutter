import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
import 'package:splitwise_flutter/features/nav/logic/nav_cubit.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import '../models/user.dart';
import '../services/group_service.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  List<User> selectedMembers = [];
  String? selectedCategory;

  final List<Map<String, dynamic>> categories = [
    {"icon": Assets.images.trip, "title": "Trip"},
    {"icon": Assets.images.people, "title": "Friends"},
    {"icon": Assets.images.love, "title": "Couple"},
    {"icon": Assets.images.home02, "title": "Home"},
    {"icon": Assets.images.briefcase02, "title": "Office"},
    {"icon": Assets.images.calendar, "title": "Event"},
    {"icon": Assets.images.users03, "title": "Family"},
    {"icon": Assets.images.other, "title": "Other"},
  ];
  static const int createIndex = 2;
  static const int homeIndex = 0;

  bool isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> handleCreateGroup() async {
    if (formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        AppAlertDialog.showErrorBar(errorMessage: 'Please select a category');

        return;
      }

      try {
        context.read<NavCubit>().addGroup(_nameController.text, "Hello");

        if (mounted) {
          context.read<NavCubit>().changePage(homeIndex);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create group: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocListener<NavCubit, NavState>(
          listenWhen: (previous, current) =>
              current.createGroupRequested! && !previous.createGroupRequested!,
          listener: (context, state) {
            handleCreateGroup();
            context.read<NavCubit>().resetCreateGroupRequest();
          },
          child: Center(
            child: Form(
              key: formKey,
              child: ListView(shrinkWrap: true, children: [
                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create Group",
                      style: tr20,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.close,
                            color: AllColors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                SizedBox(height: 24.h),

                /// Group Name
                AppTextField(
                  controller: _nameController,
                  label: "Group Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your groub name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                Divider(
                  endIndent: 0.w,
                  indent: 0.w,
                  height: 0.5,
                  color: AllColors.grey.withOpacity(0.5),
                ),
                SizedBox(height: 16.h),

                /// Categories
                Text("Categories", style: tr18),
                SizedBox(height: 12.h),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 3.5,
                  children: categories.map((cat) {
                    final isSelected = selectedCategory == cat["title"];
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedCategory = cat["title"];
                      }),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? AllColors.globalAppColor
                                : AllColors.globalAppColor.withOpacity(0.1),
                          ),
                          color: isSelected
                              ? AllColors.globalAppColor.withOpacity(0.1)
                              : AllColors.grey.withOpacity(0.05),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              cat["icon"],
                              color: isSelected
                                  ? AllColors.globalAppColor
                                  : AllColors.black,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              cat["title"],
                              style: tr12.copyWith(
                                color: isSelected
                                    ? AllColors.globalAppColor
                                    : AllColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
