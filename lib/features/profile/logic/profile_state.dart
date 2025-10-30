part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool failedState,
    ProfileModel? profile,
  }) = _ProfileState;
}
