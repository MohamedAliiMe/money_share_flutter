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

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.globalAppColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline_rounded,
                size: 60.sp, color: AllColors.green),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.congratulations.tr(),
              style: tr25.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              LocaleKeys.yourAccountIsCreated.tr(),
              style: tr13.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: AppButton(
                text: LocaleKeys.getStarted.tr(),
                onPressed: () =>
                    pushName(context, AppRoute.registerScreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
