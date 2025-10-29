import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/congratulation_screen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/create_new_password_sceen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/forget_pasword_screen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/login_screen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/register_screen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/splash_auth_screen.dart';
import 'package:splitwise_flutter/features/authentication/pages/view/splash_screen.dart';
import 'package:splitwise_flutter/features/nav/pages/view/nav_page.dart';
import 'package:splitwise_flutter/features/home/domain/model/groups/group.dart';
import 'package:splitwise_flutter/features/profile/pages/edit_profile_screen.dart';
import 'package:splitwise_flutter/features/home/pages/group_details_screen.dart';
import 'package:splitwise_flutter/features/home/pages/home_screen.dart';
import 'package:splitwise_flutter/features/profile/pages/profile_qr_cood_screen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashPage:
        return _screenInit(const SplashScreen(), settings);
      case AppRoute.splasAuthScreen:
        return _screenInit(const SplashAuthScreen(), settings);
      case AppRoute.groupDetailsScreen:
        final arg = settings.arguments as GroupModel;

        return _screenInit(
            GroupDetailsScreen(
              group: arg,
            ),
            settings);
      case AppRoute.loginScreen:
        return _screenInit(const LoginScreen(), settings);
      case AppRoute.registerScreen:
        return _screenInit(const RegisterScreen(), settings);
      case AppRoute.congratulationScreen:
        return _screenInit(const CongratulationScreen(), settings);
      case AppRoute.profileQrCodeScreen:
        return _screenInit(const ProfileQrCoodScreen(), settings);
      case AppRoute.editProfileScreen:
        return _screenInit(const EditProfileScreen(), settings);
      case AppRoute.homeScreen:
        return _screenInit(const HomeScreen(), settings);
      case AppRoute.forgetPasswordScreen:
        return _screenInit(const ForgetPaswordScreen(), settings);
      case AppRoute.navPage:
        return _screenInit(const NavPage(), settings);

      case AppRoute.createNewPasswordSceen:
        final arg = settings.arguments as String;
        return _screenInit(
            CreateNewPasswordSceen(
              emailName: arg,
            ),
            settings);
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> _screenInit(
      Widget screen, RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
        builder: (_) => screen, settings: settings);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AllColors.white,
          title: Text(LocaleKeys.error.tr()),
        ),
        body: Center(
          child: Text(LocaleKeys.someThingWentWrong.tr()),
        ),
      );
    });
  }
}
