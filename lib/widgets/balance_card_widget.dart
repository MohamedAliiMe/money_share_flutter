import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';

class BalanceCard extends StatelessWidget {
  final double totalSpent;
  final List<Map<String, dynamic>> members;

  const BalanceCard({
    super.key,
    required this.totalSpent,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AllColors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AllColors.grey.withOpacity(0.1),
          width: 0.6.w,
        ),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.images.status,
            width: 60.w,
            height: 60.h,
          ),
          SizedBox(height: 16.h),
          Text(
            "Total Spent : ${totalSpent.toStringAsFixed(0)} EGP",
            style: tsb16,
          ),
          SizedBox(height: 4.h),
          Text(
            "${members.length} Members",
            style: tr13,
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AllColors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AllColors.grey.withOpacity(0.2),
                width: 0.4,
              ),
            ),
            child: Column(
              children: members.map((member) {
                final amount = member["amount"] as num;
                final isPositive = amount >= 0;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        member["name"],
                        style: tr13,
                      ),
                      Text(
                        "${isPositive ? '+' : ''}${amount} EGP",
                        style: tsb13.copyWith(
                            color: isPositive
                                ? AllColors.greenWithOpacity
                                : AllColors.error),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
