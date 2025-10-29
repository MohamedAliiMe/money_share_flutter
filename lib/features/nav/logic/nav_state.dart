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
    CreateGroupModel? createdGroup,
    bool? createGroupRequested,
    @Default(false) bool failedState,
    @Default(false) bool showOngoingProjects,
    String? appBarTitle,
    String? appBarIcon,
    GroupModel? selectedGroup,
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
          NavEntity(
              Assets.images.home02, LocaleKeys.home.tr(), const HomeScreen()),
          NavEntity(Assets.images.activity, LocaleKeys.activity.tr(),
              const ActivityScreen()),
          NavEntity('', '', CreateGroupScreen()),
          NavEntity(Assets.images.friends, LocaleKeys.friends.tr(),
              const ActivityTab()),
          NavEntity(Assets.images.profile, LocaleKeys.profile.tr(),
              const ProfileScreen()),
        ],
        currentPage: NavEntity(
          Assets.images.home02,
          LocaleKeys.home.tr(),
          HomeScreen(),
        ),
        appBarTitle: LocaleKeys.appTitle.tr(),
        isDetailsPage: false,
      );
}
