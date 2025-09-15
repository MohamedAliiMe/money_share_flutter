// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthenticationState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get loginErrorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  String? get resitSuccessMessage => throw _privateConstructorUsedError;
  String? get resitErrorMessage => throw _privateConstructorUsedError;
  String? get otpErrorMessage => throw _privateConstructorUsedError;
  bool get failedState => throw _privateConstructorUsedError;
  bool? get failedLoginState => throw _privateConstructorUsedError;
  LoginModel? get getLogin => throw _privateConstructorUsedError;
  RegisterModel? get register => throw _privateConstructorUsedError;
  String? get userAccessToken => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticationStateCopyWith<AuthenticationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      String? loginErrorMessage,
      String? successMessage,
      String? resitSuccessMessage,
      String? resitErrorMessage,
      String? otpErrorMessage,
      bool failedState,
      bool? failedLoginState,
      LoginModel? getLogin,
      RegisterModel? register,
      String? userAccessToken});
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? loginErrorMessage = freezed,
    Object? successMessage = freezed,
    Object? resitSuccessMessage = freezed,
    Object? resitErrorMessage = freezed,
    Object? otpErrorMessage = freezed,
    Object? failedState = null,
    Object? failedLoginState = freezed,
    Object? getLogin = freezed,
    Object? register = freezed,
    Object? userAccessToken = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      loginErrorMessage: freezed == loginErrorMessage
          ? _value.loginErrorMessage
          : loginErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      resitSuccessMessage: freezed == resitSuccessMessage
          ? _value.resitSuccessMessage
          : resitSuccessMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      resitErrorMessage: freezed == resitErrorMessage
          ? _value.resitErrorMessage
          : resitErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      otpErrorMessage: freezed == otpErrorMessage
          ? _value.otpErrorMessage
          : otpErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      failedState: null == failedState
          ? _value.failedState
          : failedState // ignore: cast_nullable_to_non_nullable
              as bool,
      failedLoginState: freezed == failedLoginState
          ? _value.failedLoginState
          : failedLoginState // ignore: cast_nullable_to_non_nullable
              as bool?,
      getLogin: freezed == getLogin
          ? _value.getLogin
          : getLogin // ignore: cast_nullable_to_non_nullable
              as LoginModel?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as RegisterModel?,
      userAccessToken: freezed == userAccessToken
          ? _value.userAccessToken
          : userAccessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthenticationStateImplCopyWith<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  factory _$$AuthenticationStateImplCopyWith(_$AuthenticationStateImpl value,
          $Res Function(_$AuthenticationStateImpl) then) =
      __$$AuthenticationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      String? errorMessage,
      String? loginErrorMessage,
      String? successMessage,
      String? resitSuccessMessage,
      String? resitErrorMessage,
      String? otpErrorMessage,
      bool failedState,
      bool? failedLoginState,
      LoginModel? getLogin,
      RegisterModel? register,
      String? userAccessToken});
}

/// @nodoc
class __$$AuthenticationStateImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationStateImpl>
    implements _$$AuthenticationStateImplCopyWith<$Res> {
  __$$AuthenticationStateImplCopyWithImpl(_$AuthenticationStateImpl _value,
      $Res Function(_$AuthenticationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? loginErrorMessage = freezed,
    Object? successMessage = freezed,
    Object? resitSuccessMessage = freezed,
    Object? resitErrorMessage = freezed,
    Object? otpErrorMessage = freezed,
    Object? failedState = null,
    Object? failedLoginState = freezed,
    Object? getLogin = freezed,
    Object? register = freezed,
    Object? userAccessToken = freezed,
  }) {
    return _then(_$AuthenticationStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      loginErrorMessage: freezed == loginErrorMessage
          ? _value.loginErrorMessage
          : loginErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      resitSuccessMessage: freezed == resitSuccessMessage
          ? _value.resitSuccessMessage
          : resitSuccessMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      resitErrorMessage: freezed == resitErrorMessage
          ? _value.resitErrorMessage
          : resitErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      otpErrorMessage: freezed == otpErrorMessage
          ? _value.otpErrorMessage
          : otpErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      failedState: null == failedState
          ? _value.failedState
          : failedState // ignore: cast_nullable_to_non_nullable
              as bool,
      failedLoginState: freezed == failedLoginState
          ? _value.failedLoginState
          : failedLoginState // ignore: cast_nullable_to_non_nullable
              as bool?,
      getLogin: freezed == getLogin
          ? _value.getLogin
          : getLogin // ignore: cast_nullable_to_non_nullable
              as LoginModel?,
      register: freezed == register
          ? _value.register
          : register // ignore: cast_nullable_to_non_nullable
              as RegisterModel?,
      userAccessToken: freezed == userAccessToken
          ? _value.userAccessToken
          : userAccessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthenticationStateImpl implements _AuthenticationState {
  const _$AuthenticationStateImpl(
      {this.isLoading = false,
      this.errorMessage,
      this.loginErrorMessage,
      this.successMessage,
      this.resitSuccessMessage,
      this.resitErrorMessage,
      this.otpErrorMessage,
      this.failedState = false,
      this.failedLoginState,
      this.getLogin,
      this.register,
      this.userAccessToken});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  final String? loginErrorMessage;
  @override
  final String? successMessage;
  @override
  final String? resitSuccessMessage;
  @override
  final String? resitErrorMessage;
  @override
  final String? otpErrorMessage;
  @override
  @JsonKey()
  final bool failedState;
  @override
  final bool? failedLoginState;
  @override
  final LoginModel? getLogin;
  @override
  final RegisterModel? register;
  @override
  final String? userAccessToken;

  @override
  String toString() {
    return 'AuthenticationState(isLoading: $isLoading, errorMessage: $errorMessage, loginErrorMessage: $loginErrorMessage, successMessage: $successMessage, resitSuccessMessage: $resitSuccessMessage, resitErrorMessage: $resitErrorMessage, otpErrorMessage: $otpErrorMessage, failedState: $failedState, failedLoginState: $failedLoginState, getLogin: $getLogin, register: $register, userAccessToken: $userAccessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.loginErrorMessage, loginErrorMessage) ||
                other.loginErrorMessage == loginErrorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.resitSuccessMessage, resitSuccessMessage) ||
                other.resitSuccessMessage == resitSuccessMessage) &&
            (identical(other.resitErrorMessage, resitErrorMessage) ||
                other.resitErrorMessage == resitErrorMessage) &&
            (identical(other.otpErrorMessage, otpErrorMessage) ||
                other.otpErrorMessage == otpErrorMessage) &&
            (identical(other.failedState, failedState) ||
                other.failedState == failedState) &&
            (identical(other.failedLoginState, failedLoginState) ||
                other.failedLoginState == failedLoginState) &&
            (identical(other.getLogin, getLogin) ||
                other.getLogin == getLogin) &&
            (identical(other.register, register) ||
                other.register == register) &&
            (identical(other.userAccessToken, userAccessToken) ||
                other.userAccessToken == userAccessToken));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      errorMessage,
      loginErrorMessage,
      successMessage,
      resitSuccessMessage,
      resitErrorMessage,
      otpErrorMessage,
      failedState,
      failedLoginState,
      getLogin,
      register,
      userAccessToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationStateImplCopyWith<_$AuthenticationStateImpl> get copyWith =>
      __$$AuthenticationStateImplCopyWithImpl<_$AuthenticationStateImpl>(
          this, _$identity);
}

abstract class _AuthenticationState implements AuthenticationState {
  const factory _AuthenticationState(
      {final bool isLoading,
      final String? errorMessage,
      final String? loginErrorMessage,
      final String? successMessage,
      final String? resitSuccessMessage,
      final String? resitErrorMessage,
      final String? otpErrorMessage,
      final bool failedState,
      final bool? failedLoginState,
      final LoginModel? getLogin,
      final RegisterModel? register,
      final String? userAccessToken}) = _$AuthenticationStateImpl;

  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  String? get loginErrorMessage;
  @override
  String? get successMessage;
  @override
  String? get resitSuccessMessage;
  @override
  String? get resitErrorMessage;
  @override
  String? get otpErrorMessage;
  @override
  bool get failedState;
  @override
  bool? get failedLoginState;
  @override
  LoginModel? get getLogin;
  @override
  RegisterModel? get register;
  @override
  String? get userAccessToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthenticationStateImplCopyWith<_$AuthenticationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
