import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/nav/domain/entity/nav_entity.dart';
import 'package:splitwise_flutter/features/nav/logic/nav_cubit.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();
  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.group_add),
              title: const Text('New Group'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('New Expense'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                BlocListener<AuthenticationCubit, AuthenticationState>(
                  bloc: _authenticationCubit,
                  listener: (context, state) {
                    if (state.successMessage != null) {
                      AppAlertDialog.showSuccessBar(
                          message: state.successMessage);
                      popAllAndPushName(context, AppRoute.splasAuthScreen);
                    } else {
                      AppAlertDialog.showErrorBar(
                          errorMessage: state.errorMessage);
                    }
                  },
                  child: IconButton(
                      onPressed: () {
                        _authenticationCubit.logout();
                      },
                      icon: Icon(Icons.logout_rounded)),
                )
              ],
            ),
            body: state.currentPage?.page,
            bottomNavigationBar: SizedBox(
              height: 90.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  NavBarBackground(),
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(state.navPages.length, (index) {
                        final item = state.navPages[index];
                        final isSelected = state.currentIndex == index;

                        if (index == 2) {
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
                      onTap: () => _showAddDialog(context),
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
                          Icons.add,
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

  Widget _buildNavItem(
    BuildContext context,
    NavEntity item,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => context.read<NavCubit>().changePage(index),
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
