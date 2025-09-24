part of 'nav_cubit.dart';

@freezed
class NavState with _$NavState {
  factory NavState({
    @Default(0) int currentIndex,
    @Default([]) List<Widget> pages,
    @Default([]) List<NavEntity> navPages,
    NavEntity? currentPage,
    @Default({}) Map<int, UniqueKey> pageKeys,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(false) bool failedState,
    @Default(false) bool showOngoingProjects,
  }) = _NavState;

  factory NavState.initial() => NavState(
        currentIndex: 0,
        pages: const [
          GroupsTab(),
          ActivityTab(),
          SizedBox.shrink(),
          ActivityTab(),
          ProfileScreen(),
        ],
        navPages: [
          NavEntity(Assets.images.home02, 'Home', const GroupsTab()),
          NavEntity(Assets.images.activity, 'Activity', const ActivityTab()),
          NavEntity('', '', SizedBox.shrink()),
          NavEntity(Assets.images.friends, 'Friends', const ActivityTab()),
          NavEntity(Assets.images.profile, 'Profile', const ProfileScreen()),
        ],
        currentPage: NavEntity(
          Assets.images.home02,
          'Home',
          GroupsTab(),
        ),
      );
}
