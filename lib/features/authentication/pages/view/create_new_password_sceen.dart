import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_loading_widget.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class CreateNewPasswordSceen extends StatefulWidget {
  final String emailName;
  const CreateNewPasswordSceen({super.key, required this.emailName});

  @override
  State<CreateNewPasswordSceen> createState() => _CreateNewPasswordSceenState();
}

class _CreateNewPasswordSceenState extends State<CreateNewPasswordSceen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();

  bool _newPassword = false;
  bool _newPasswordCreated = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _newPassword = true;
        _newPasswordCreated = true;
      });
      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        _newPassword = false;
        _passwordController.clear();
        _confirmPasswordController.clear();
      });

      // await _authenticationCubit.getLogin(
      //   loginParams: LoginParams(
      //     email: _passwordController.text.trim(),
      //     password: _passwordController.text.trim(),
      //   ),
      // );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                    Text(LocaleKeys.createNewPassword.tr(), style: tsb25),
                    SizedBox(height: 24.h),
                    _newPasswordCreated
                        ? Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.yourEmail.tr(),
                                          style: tsb16),
                                      Text(widget.emailName, style: tr16),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _newPasswordCreated = false;
                                      _passwordController.clear();
                                    });
                                  },
                                  child: Icon(Icons.close, color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 24.h,
                    ),

                    /// Password
                    AppTextField(
                      controller: _passwordController,
                      label: LocaleKeys.newPassword.tr(),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.pleaseEnterYourPassword.tr();
                        }
                        if (value.length < 6) {
                          return LocaleKeys.passwordMustBeAtLeast6Characters
                              .tr();
                        }
                        return null;
                      },
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
                    SizedBox(height: 17.h),

                    /// Confirm Password
                    AppTextField(
                      controller: _confirmPasswordController,
                      label: LocaleKeys.confirmNewPassword.tr(),
                      obscureText: _obscureConfirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.pleaseConfirmYourPassword.tr();
                        }
                        if (value != _confirmPasswordController.text) {
                          return LocaleKeys.passwordsDoNotMatch.tr();
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AllColors.globalAppColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppButton(
                      text: LocaleKeys.continues.tr(),
                      onPressed: _handleLogin,
                      color: AllColors.globalAppColor,
                      textColor: AllColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_newPassword) AppLoadingWidget()
      ],
    );
  }
}
