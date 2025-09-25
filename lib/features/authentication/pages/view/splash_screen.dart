import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/login_screen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/splash_auth_screen.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/nav/pages/view/nav_page.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationCubit _authBloc = getIt<AuthenticationCubit>();

  @override
  void initState() {
    super.initState();
    _authBloc.getCustomerAccessToken().then((token) {
      _navigate(token);
    });
  }

  void _navigate(String? token) {
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      pushPageWithAnimationTransition(
        context,
        token == null ? const SplashAuthScreen() : NavPage(),
        _buildSplash(),
        const Duration(seconds: 2),
      );
    });
  }

  Widget _buildSplash() {
    return Scaffold(
      backgroundColor: AllColors.globalAppColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(Assets.images.splashTopRight.path),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(Assets.images.splaasgBouttomLeft.path),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.iconInterfaceSolid.path,
                  width: 48.w,
                  height: 48.h,
                ),
                Text(
                  LocaleKeys.splitsmart.tr(),
                  style: tsb31.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      bloc: _authBloc,
      listenWhen: (prev, curr) => prev.userAccessToken != curr.userAccessToken,
      listener: (context, state) {
        _navigate(state.userAccessToken);
      },
      child: _buildSplash(),
    );
  }
}
