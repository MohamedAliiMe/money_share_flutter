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
    bool? succses,
    bool? createGroup,
    String? groupName,
    String? description,
    bool? createGroupRequested,
    @Default(false) bool failedState,
    @Default(false) bool showOngoingProjects,
    String? appBarTitle,
    String? appBarIcon,
    @Default(false) bool isDetailsPage,
  }) = _NavState;

  factory NavState.initial() => NavState(
        currentIndex: 0,
        createGroupRequested: false,
        pages: [
          const HomeScreen(),
          const ActivityScreen(),
          CreateGroupScreen(),
          const ActivityTab(),
          const ProfileScreen(),
        ],
        navPages: [
          NavEntity(Assets.images.home02, 'Home', const HomeScreen()),
          NavEntity(Assets.images.activity, 'Activity', const ActivityScreen()),
          NavEntity('', '', CreateGroupScreen()),
          NavEntity(Assets.images.friends, 'Friends', const ActivityTab()),
          NavEntity(Assets.images.profile, 'Profile', const ProfileScreen()),
        ],
        currentPage: NavEntity(
          Assets.images.home02,
          'Home',
          HomeScreen(),
        ),
        appBarTitle: "Splitsmart",
        isDetailsPage: false,
      );
}
