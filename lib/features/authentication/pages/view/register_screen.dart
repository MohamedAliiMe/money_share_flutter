import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/data/models/regester_params/regester_params.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthenticationCubit _authCubit = getIt<AuthenticationCubit>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authProvider = _authCubit;
        await authProvider.register(
            registerParams: RegisterParams(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                passwordConfirmation: _confirmPasswordController.text));
        if (mounted) {}
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                Text(LocaleKeys.signUp.tr(), style: tsb25),
                SizedBox(height: 6.h),
                Text(
                  LocaleKeys.letsCreateAnAccount.tr(),
                  style: tr13.copyWith(color: AllColors.grey),
                ),
                SizedBox(height: 24.h),

                /// Name
                AppTextField(
                  controller: _nameController,
                  label: LocaleKeys.name.tr(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.pleaseEnterYourName.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 17.h),

                /// Email
                AppTextField(
                  controller: _emailController,
                  label: LocaleKeys.email.tr(),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.pleaseEnterYourEmail.tr();
                    }
                    if (!value.contains('@')) {
                      return LocaleKeys.enterValidEmail.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 17.h),

                /// Password
                AppTextField(
                    controller: _passwordController,
                    label: LocaleKeys.password.tr(),
                    keyboardType: TextInputType.text,
                    obscureText: _obscurePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.pleaseEnterYourPassword.tr();
                      }
                      if (value.length < 6) {
                        return LocaleKeys.passwordMustBeAtLeast6Characters.tr();
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AllColors.globalAppColor,
                      ),
                    )),
                SizedBox(height: 17.h),

                /// Confirm Password
                AppTextField(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AllColors.globalAppColor,
                    ),
                  ),
                  controller: _confirmPasswordController,
                  label: LocaleKeys.confirmPassword.tr(),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.pleaseConfirmYourPassword.tr();
                    }
                    if (value != _passwordController.text) {
                      return LocaleKeys.passwordsDoNotMatch.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                BlocConsumer<AuthenticationCubit, AuthenticationState>(
                  bloc: _authCubit,
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      AppAlertDialog.showErrorBar(
                        errorMessage: state.errorMessage,
                      );
                      return;
                    }

                    if (state.failedState == true &&
                        state.errorMessage != null) {
                      AppAlertDialog.showErrorBar(
                        errorMessage: state.errorMessage,
                      );
                      return;
                    }

                    if (state.successMessage != null ||
                        state.register != null) {
                      AppAlertDialog.showSuccessBar(
                        message: LocaleKeys.doneSuccessfully.tr(),
                      );
                      popAllAndPushName(context, AppRoute.congratulationScreen);
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      text: LocaleKeys.signUp.tr(),
                      icon: Icons.login,
                      onPressed: _handleRegister,
                      color: AllColors.globalAppColor,
                      textColor: AllColors.white,
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: tr13),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () {
                        popScreen(context);
                      },
                      child: Text(
                        'Login',
                        style: tsb13.copyWith(color: AllColors.globalAppColor),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
