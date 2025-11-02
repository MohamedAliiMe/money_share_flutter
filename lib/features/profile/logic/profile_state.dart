part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  factory ProfileState({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool failedState,
    ProfileModel? profile,
    CurrencyListModel? currencies,
    CountryListModel? countries,
    CategoryListModel? categories,
  }) = _ProfileState;
}
