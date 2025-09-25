import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double? width;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AllColors.white,
    this.textColor = AllColors.black,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: tr16.copyWith(color: textColor)),
              SizedBox(width: 8.w),
              if (icon != null) ...[
                Icon(
                  icon,
                  color: textColor,
                  size: 15.sp,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
