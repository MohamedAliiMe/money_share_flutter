import 'dart:developer';

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
import 'package:splitwise_flutter/features/nav/domain/entity/nav_entity.dart';
import 'package:splitwise_flutter/features/nav/logic/nav_cubit.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/widgets/searsh_friendes_dialog_widget.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();

  bool isCreating = false;

  static const int createIndex = 2;
  static const int homeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          if (state.currentIndex != createIndex && isCreating) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => isCreating = false);
            });
          } else if (state.currentIndex == createIndex && !isCreating) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => isCreating = true);
            });
          }

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  if (state.isDetailsPage) ...[
                    if (state.appBarIcon != null)
                      SvgPicture.asset(
                        state.appBarIcon!,
                        width: 28.w,
                        height: 28.h,
                      ),
                    SizedBox(width: 8.w),
                    Expanded(
                        child: Text(state.appBarTitle ?? "", style: tsb20)),
                    const Spacer(),
                    SvgPicture.asset(Assets.images.setting2),
                    12.w.horizontalSpace,
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 24.h),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Share Group",
                                            style: tr20,
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: const Icon(Icons.close,
                                                color: AllColors.grey),
                                          ),
                                        ],
                                      ),
                                      12.h.verticalSpace,
                                      Divider(
                                        height: 0,
                                        color: AllColors.grey
                                            .withValues(alpha: 0.2),
                                      ),
                                      24.h.verticalSpace,
                                      _contantShareDialog(Assets.images.shareCq,
                                          "Share Qr Code"),
                                      _contantShareDialog(
                                          Assets.images.shareCopyLink,
                                          "Share Group Link"),
                                    ]),
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(Assets.images.share)),
                  ] else ...[
                    Image.asset(
                      Assets.images.iconInterfaceSolid.path,
                      width: 35.w,
                      height: 35.h,
                      color: AllColors.globalAppColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(state.appBarTitle ?? "", style: tsb20),
                    const Spacer(),
                    if (state.currentIndex != 4)
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => const SearchFriendsDialog());
                          },
                          child: SvgPicture.asset(Assets.images.searsh)),
                  ],
                ],
              ),
            ),
            body: state.currentPage?.page,
            bottomNavigationBar: SizedBox(
              height: 90.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const NavBarBackground(),
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(state.navPages.length, (index) {
                        final item = state.navPages[index];
                        final isSelected = state.currentIndex == index;

                        if (index == createIndex) {
                          return Row(
                            children: [
                              SizedBox(width: 60.w),
                              _buildNavItem(context, item, index, isSelected),
                            ],
                          );
                        }

                        return _buildNavItem(context, item, index, isSelected);
                      }),
                    ),
                  ),
                  Positioned(
                    top: -25.h,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _onMiddleButtonPressed(context, state),
                      child: Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: AllColors.globalAppColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AllColors.globalAppColor.withOpacity(0.6),
                              blurRadius: 10.r,
                              spreadRadius: 3.r,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        child: Icon(
                          (isCreating || state.currentIndex == createIndex)
                              ? Icons.check
                              : Icons.add,
                          color: Colors.white,
                          size: 32.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _contantShareDialog(String icon, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AllColors.grey.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 8.w),
          Text(description, style: tr16),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavEntity item,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        if (index == createIndex) {
          context.read<NavCubit>().changePage(createIndex);

          setState(() => isCreating = true);
          return;
        }
        context.read<NavCubit>().resetAppBarToHome();

        context.read<NavCubit>().changePage(index);
        if (isCreating) setState(() => isCreating = false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(item.icon,
              color: isSelected ? AllColors.globalAppColor : AllColors.grey),
          Text(item.title,
              style: tr13.copyWith(
                color: isSelected ? AllColors.globalAppColor : AllColors.grey,
              )),
        ],
      ),
    );
  }

  void _onMiddleButtonPressed(BuildContext context, NavState state) {
    if (state.currentIndex == 2) {
      context.read<NavCubit>().requestCreateGroup(
            "New Group Name",
            "Description",
          );
    } else {
      context.read<NavCubit>().changePage(2);
    }
  }
}

class NavBarBackground extends StatelessWidget {
  const NavBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 90),
      painter: _NavBarPainter(),
    );
  }
}

class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AllColors.whiteBase
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 20)
      ..quadraticBezierTo(size.width * 0.05, 0, size.width * 0.15, 0)
      ..lineTo(size.width * 0.37, 0)
      ..quadraticBezierTo(
        size.width * 0.5,
        -65,
        size.width * 0.63,
        0,
      )
      ..lineTo(size.width * 0.85, 0)
      ..quadraticBezierTo(size.width * 0.95, 0, size.width, 20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
