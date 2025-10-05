import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/widgets/add_expense_sheet_widget.dart';

class SearchFriendsDialog extends StatefulWidget {
  final String? title;
  final String? hintText;
  final String? textButton;
  final String? imagePath;
  const SearchFriendsDialog(
      {super.key, this.title, this.hintText, this.textButton, this.imagePath});

  @override
  State<SearchFriendsDialog> createState() => _SearchFriendsDialogState();
}

class _SearchFriendsDialogState extends State<SearchFriendsDialog> {
  String searchQuery = "";
  bool isAdded = false;

  final List<Map<String, String>> members = [
    {"name": "Mohamed", "email": "mohamed@gmail.com"},
    // {"name": "Ali", "email": "ali@gmail.com"},
    // {"name": "Sara", "email": "sara@gmail.com"},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title ?? "Add Member",
                  style: tr20,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AllColors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            8.h.verticalSpace,
            Divider(
              height: 0,
              color: AllColors.grey.withValues(alpha: 0.5),
            ),
            24.h.verticalSpace,
            LabeledTextField(
              label: widget.hintText ?? "Search Members",
              hint: "Search Friends..",
              keyboardType: TextInputType.text,
              prefixIcon: SvgPicture.asset(
                Assets.images.searsh,
                color: AllColors.grey,
                fit: BoxFit.scaleDown,
              ),
            ),
            24.h.verticalSpace,
            ...members
                .where((m) => m["name"]!.toLowerCase().contains(searchQuery))
                .map((m) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isAdded = !isAdded;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 6.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isAdded
                          ? AllColors.globalAppColor
                          : AllColors.grey.withValues(alpha: 0.3),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            AllColors.globalAppColor.withValues(alpha: 0.2),
                        child: Text(m["name"]![0], style: tr16),
                      ),
                      8.w.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(m["name"]!, style: tr16),
                            Text(m["email"]!,
                                style: tr10.copyWith(
                                    color:
                                        AllColors.grey.withValues(alpha: 0.9))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            32.h.verticalSpace,
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: AllColors.globalAppColor,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                          color: AllColors.globalAppColor.withOpacity(0.1))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.textButton ?? "Add",
                        style: tr13.copyWith(color: AllColors.white),
                      ),
                      8.w.horizontalSpace,
                      Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                widget.textButton != null ? null : Colors.white,
                          ),
                          child: SvgPicture.asset(
                            widget.imagePath ?? Assets.images.plus,
                            color: widget.textButton != null
                                ? null
                                : AllColors.grey,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
