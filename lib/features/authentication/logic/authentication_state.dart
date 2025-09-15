part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(false) bool isLoading,
    String? errorMessage,
    String? loginErrorMessage,
    String? successMessage,
    String? resitSuccessMessage,
    String? resitErrorMessage,
    String? otpErrorMessage,
    @Default(false) bool failedState,
    bool? failedLoginState,
    LoginModel? getLogin,
    RegisterModel? register,
    String? userAccessToken,
  }) = _AuthenticationState;
}
