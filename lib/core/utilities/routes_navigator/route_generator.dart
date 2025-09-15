import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
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
