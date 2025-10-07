import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/utilities/app_data_storage.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/core/utilities/static_data.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/pages/group_details_screen.dart';
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
              LocaleKeys.profile.tr(),
              actionText: LocaleKeys.qrCode.tr(),
              onAction: () {
                pushName(context, AppRoute.profileQrCodeScreen);
              },
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
                    child: Text("M", style: tr20),
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
                  GestureDetector(
                    onTap: () {
                      pushName(context, AppRoute.editProfileScreen);
                    },
                    child: Icon(Icons.mode_edit_outlined,
                        size: 24.sp, color: AllColors.globalAppColor),
                  ),
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
                        Text(LocaleKeys.splitsmartPro.tr(),
                            style: tsb16.copyWith(color: Colors.white)),
                        SizedBox(height: 4.h),
                        Text(LocaleKeys.goProDescription.tr(),
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
            _buildSettingItem(Assets.images.star01, LocaleKeys.ratingUs.tr()),
            GestureDetector(
              onTap: () => showLogoutDialog(context),
              child: _buildSettingItem(Assets.images.logOut01, LocaleKeys.logout.tr()),
            ),
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
          const Icon(Icons.chevron_right, color: Colors.black),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: SvgPicture.asset(Assets.images.logOutDialog)),
                SizedBox(height: 16.h),
                Text(LocaleKeys.logout.tr(), style: tsb16),
                SizedBox(height: 4.h),
                Text(
                  LocaleKeys.logoutConfirmation.tr(),
                  style: tr13.copyWith(color: AllColors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: LocaleKeys.logout.tr(),
                        onPressed: () async {
                          final cubit = context.read<AuthenticationCubit>();
                          await cubit.logout();
                          Navigator.pop(context);
                          popAllAndPushName(context, AppRoute.loginScreen);
                        },
                        color: AllColors.globalAppColor,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: AppButton(
                        text: LocaleKeys.cancel.tr(),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.white,
                        textColor: AllColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
