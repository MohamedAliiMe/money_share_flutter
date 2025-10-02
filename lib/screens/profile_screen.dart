import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/screens/group_details_screen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(
              "Profile",
              actionText: "QR Code",
              onAction: () {},
              hasIcon: true,
              assetName: Assets.images.qrCode01,
              hasBadding: true,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              margin: EdgeInsets.symmetric(vertical: 24.h),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AllColors.grey.withOpacity(0.2), width: 1.w),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor:
                        AllColors.globalAppColor.withValues(alpha: 0.2),
                    child: Text(
                      "M",
                      style: tr20,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mohamed Ahmed", style: tsb16),
                        SizedBox(height: 4.h),
                        Text("mohamedahmed@gmail.com",
                            style: tr13.copyWith(color: AllColors.grey)),
                      ],
                    ),
                  ),
                  Icon(Icons.mode_edit_outlined,
                      size: 24.sp, color: AllColors.globalAppColor),
                ],
              ),
            ),

            Divider(color: AllColors.grey.withOpacity(0.3), height: 0),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: AllColors.globalAppColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Splitsmart Pro",
                            style: tsb16.copyWith(color: Colors.white)),
                        SizedBox(height: 4.h),
                        Text("Go Pro for smarter expense sharing",
                            style: tr13.copyWith(color: Colors.white)),
                      ]),
                  SvgPicture.asset(Assets.images.touchTheProfile),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            _buildSettingItem(Assets.images.currencyPound, "EGP"),
            _buildSettingItem(Assets.images.flag01, "Egypt"),
            _buildSettingItem(Assets.images.globe02, "English"),
            _buildSettingItem(Assets.images.star01, "Rating Us"),
            _buildSettingItem(Assets.images.logOut01, "Logout"),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.iconInterfaceSolid.path,
                  width: 32.w,
                  height: 32.h,
                  color: AllColors.globalAppColor,
                ),
                SizedBox(width: 8.w),
                Text(LocaleKeys.splitsmart.tr(), style: tsb16),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(String icon, String title, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(title, style: tsb16),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
