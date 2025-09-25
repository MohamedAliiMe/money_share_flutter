import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();
  final groups = [
    {
      "name": "Hurghada000000000000000000000000000000",
      "members": "0 Member",
      "activity": "No Activity yet",
      "status": "No Expenses yet",
      "statusColor": AllColors.grey,
      "icon": Assets.images.house,
    },
    {
      "name": "Dahab",
      "members": "4 Members",
      "activity": "You added Dinner",
      "status": "Receive 250 EGP",
      "statusColor": AllColors.green,
      "icon": Assets.images.airplane,
    },
    {
      "name": "Apartment",
      "members": "You, Omar",
      "activity": "Omar added Rent",
      "status": "Pay 250 EGP",
      "statusColor": AllColors.red,
      "icon": Assets.images.heart,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              Assets.images.iconInterfaceSolid.path,
              width: 35.w,
              height: 35.h,
              color: AllColors.globalAppColor,
            ),
            SizedBox(width: 8.w),
            Text(LocaleKeys.splitsmart.tr(), style: tsb20),
          ],
        ),
        actions: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            bloc: _authenticationCubit,
            listener: (context, state) {
              if (state.successMessage != null) {
                AppAlertDialog.showSuccessBar(message: state.successMessage);
                popAllAndPushName(context, AppRoute.splasAuthScreen);
              } else {
                AppAlertDialog.showErrorBar(errorMessage: state.errorMessage);
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GestureDetector(
                child: SvgPicture.asset(Assets.images.searsh),
                onTap: () {},
              ),
            ),
          )
        ],
      ),
      body: groups.isEmpty ? _buildEmptyState(context) : _buildGroupsList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: "Ready to ",
                  style: tr13.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Splitsmart?",
                      style: tr13.copyWith(
                        color: AllColors.globalAppColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: "\nCreate your first group now!"),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              AppButton(
                text: "Add Group",
                color: AllColors.globalAppColor,
                textColor: AllColors.white,
                onPressed: () {
                  // Navigate to Create Group Screen
                },
                width: 182.w,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildGroupsList() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Groups",
                style: tr20,
              ),
              GestureDetector(
                  onTap: () {}, child: SvgPicture.asset(Assets.images.filter)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AllColors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AllColors.grey.withOpacity(0.03),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor:
                          AllColors.globalAppColor.withOpacity(0.15),
                      child: SvgPicture.asset(group['icon'].toString()),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  group["name"].toString(),
                                  style: tr16,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  group["status"].toString(),
                                  style: tr13.copyWith(
                                    color: group["statusColor"] as Color,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(group["members"].toString(),
                              style: tr13.copyWith(color: AllColors.grey)),
                          Text(group["activity"].toString(),
                              style: tr13.copyWith(color: AllColors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
