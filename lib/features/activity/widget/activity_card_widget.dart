import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/models/activity.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    final isIncome = activity.amount > 0;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AllColors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AllColors.grey.withOpacity(0.03),
            width: 1.w,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "${activity.userName == "You" ? "You" : activity.userName} added new expense for ${activity.description} (${activity.amount.abs().toStringAsFixed(0)} EGP)",
                  style: tr16,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "${isIncome ? "+" : "-"}${activity.amount.abs()} EGP",
                style: tr13.copyWith(
                  color: isIncome ? AllColors.greenWithOpacity : AllColors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SvgPicture.asset(Assets.images.plane, width: 16.w, height: 16.h),
              SizedBox(width: 6.w),
              Text(
                activity.groupName,
                style:
                    tr13.copyWith(color: AllColors.grey.withValues(alpha: 0.9)),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(Assets.images.clock, width: 16.w, height: 16.h),
              SizedBox(width: 4.w),
              Text(
                "${activity.createdAt.hour.toString().padLeft(2, "0")}:${activity.createdAt.minute.toString().padLeft(2, "0")} ${activity.createdAt.hour >= 12 ? "pm" : "am"}",
                style:
                    tr13.copyWith(color: AllColors.grey.withValues(alpha: 0.9)),
              ),
            ],
          ),
        ]));
  }
}
