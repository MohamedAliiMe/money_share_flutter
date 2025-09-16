import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.globalAppColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.iconInterfaceSolid.path,
                    width: 87.w,
                    height: 87.h,
                  ),
                  Text(
                    LocaleKeys.splitsmart.tr(),
                    style: tsb30.copyWith(
                      color: Colors.white,
                      fontSize: 31.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                LocaleKeys.welcome.tr(),
                style: tsb30.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                ' ${LocaleKeys.smartWayToManageSharedExpenses.tr()} ',
                style: tsb13.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              AppButton(
                text: LocaleKeys.login.tr(),
                icon: Icons.login,
                onPressed: () => pushName(context, AppRoute.loginScreen),
              ),
              SizedBox(height: 16.h),
              AppButton(
                text: LocaleKeys.signUp.tr(),
                onPressed: () => pushName(context, AppRoute.registerScreen),
              ),
              SizedBox(height: 32.h),
              Text(
                LocaleKeys.termsAndContactUs.tr(),
                style: tr13,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
