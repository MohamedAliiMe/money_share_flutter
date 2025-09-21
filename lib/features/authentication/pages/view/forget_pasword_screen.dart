import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_params/login_params.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class ForgetPaswordScreen extends StatefulWidget {
  const ForgetPaswordScreen({super.key});

  @override
  State<ForgetPaswordScreen> createState() => _ForgetPaswordScreenState();
}

class _ForgetPaswordScreenState extends State<ForgetPaswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();

  bool _emailSubmitted = false;

  Future<void> _handleLogin() async {
    if (_emailSubmitted) {
      pushNameWithArguments(
          context, AppRoute.createNewPasswordSceen, _emailController.text);
      return;
    }
    if (_formKey.currentState!.validate()) {
      setState(() {
        _emailSubmitted = true;
      });
      await _authenticationCubit.getLogin(
        loginParams: LoginParams(
          email: _emailController.text.trim(),
          password: _emailController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Image.asset(
                      Assets.images.iconInterfaceSolid.path,
                      width: 32.w,
                      height: 32.h,
                      color: AllColors.globalAppColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(LocaleKeys.splitsmart.tr(), style: tsb25),
                  ],
                ),
                SizedBox(height: 40.h),
                Text(LocaleKeys.forgetPassword.tr(), style: tsb25),
                SizedBox(height: 24.h),
                _emailSubmitted
                    ? Text(
                        _emailController.text.trim(),
                        style: tsb16.copyWith(
                          color: AllColors.globalAppColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : AppTextField(
                        controller: _emailController,
                        label: LocaleKeys.email.tr(),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || !value.contains('@')
                                ? LocaleKeys.enterValidEmail.tr()
                                : null,
                      ),
                SizedBox(height: 24.h),
                AppButton(
                  text: LocaleKeys.continues.tr(),
                  onPressed: _handleLogin,
                  color: AllColors.globalAppColor,
                  textColor: AllColors.white,
                ),
                SizedBox(height: 24.h),
                if (_emailSubmitted)
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AllColors.globalAppColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: AllColors.globalAppColor,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocaleKeys.checkYourEmail.tr(),
                                  style: tsb16),
                              Text(
                                  LocaleKeys.forGetAccessToCreateNewPassword
                                      .tr(),
                                  style: tr16),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _emailSubmitted = false;
                              _emailController.clear();
                            });
                          },
                          child: Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.remeberYourPassword.tr()),
            GestureDetector(
              onTap: () {
                pushName(context, AppRoute.registerScreen);
              },
              child: Text(
                LocaleKeys.login.tr(),
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
