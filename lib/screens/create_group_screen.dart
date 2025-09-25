import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
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
  final _groupService = GroupService();
  List<User> selectedMembers = [];
  String? selectedCategory;

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.flight_takeoff, "title": "Trip"},
    {"icon": Icons.favorite, "title": "Couple"},
    {"icon": Icons.card_giftcard, "title": "Office"},
    {"icon": Icons.group, "title": "Family"},
    {"icon": Icons.people, "title": "Friends"},
    {"icon": Icons.home, "title": "Home"},
    {"icon": Icons.event, "title": "Event"},
    {"icon": Icons.more_horiz, "title": "Other"},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> handleCreateGroup() async {
    if (formKey.currentState!.validate()) {
      if (selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category')),
        );
        return;
      }
      if (selectedMembers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one member')),
        );
        return;
      }

      try {
        final memberIds = selectedMembers.map((user) => user.id).toList();
        await _groupService.createGroup(_nameController.text, memberIds);
        if (mounted) Navigator.pop(context, true);
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
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                /// Title
                Text(
                  "Create Group",
                  style: tr20,
                ),
                SizedBox(height: 20.h),

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
                SizedBox(height: 24.h),

                /// Categories
                Text("Categories", style: tr18),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: categories.map((cat) {
                    final isSelected = selectedCategory == cat["title"];
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedCategory = cat["title"];
                      }),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? AllColors.globalAppColor
                                : AllColors.grey.withOpacity(0.3),
                          ),
                          color: isSelected
                              ? AllColors.globalAppColor.withOpacity(0.1)
                              : AllColors.grey.withOpacity(0.05),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(cat["icon"],
                                size: 18.sp,
                                color: isSelected
                                    ? AllColors.globalAppColor
                                    : AllColors.grey),
                            SizedBox(width: 6.w),
                            Text(cat["title"],
                                style: tr12.copyWith(
                                  color: isSelected
                                      ? AllColors.globalAppColor
                                      : AllColors.grey,
                                )),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
