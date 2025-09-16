import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/data/models/login_params/login_params.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await _authenticationCubit.getLogin(
        loginParams: LoginParams(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
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
                Text(LocaleKeys.login.tr(), style: tsb25),
                SizedBox(height: 6.h),
                Text(
                  LocaleKeys.letsGetStart.tr(),
                  style: tr13.copyWith(color: AllColors.grey),
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  controller: _emailController,
                  label: LocaleKeys.email.tr(),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || !value.contains('@')
                      ? LocaleKeys.enterValidEmail.tr()
                      : null,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _passwordController,
                  label: LocaleKeys.password.tr(),
                  obscureText: _obscurePassword,
                  validator: (value) => value == null || value.length < 6
                      ? LocaleKeys.passwordIsWrong.tr()
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AllColors.globalAppColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.forgetPassword.tr(),
                    style: TextStyle(
                        color: AllColors.globalAppColor, fontSize: 12.sp),
                  ),
                ),
                SizedBox(height: 24.h),
                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  bloc: _authenticationCubit,
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: LocaleKeys.login.tr(),
                      icon: Icons.login,
                      onPressed: _handleLogin,
                      color: AllColors.globalAppColor,
                      textColor: AllColors.white,
                    );
                  },
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
            Text(LocaleKeys.newUser.tr()),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: Text(
                LocaleKeys.createAccount.tr(),
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
