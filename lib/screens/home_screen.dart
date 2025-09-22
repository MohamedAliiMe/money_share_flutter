import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';

import '../providers/auth_provider.dart';
import '../models/group.dart';
import '../providers/groups_provider.dart';
import 'create_group_screen.dart';
import 'create_expense_screen.dart';
import 'profile_screen.dart';
import 'friends_screen.dart';
import 'tabs/groups_tab.dart';
import 'tabs/activity_tab.dart';

class CustomStyle extends StyleHook {
  @override
  double get activeIconSize => 36.sp;
  @override
  double get activeIconMargin => 6.w;
  @override
  double get iconSize => 24.sp;

  @override
  TextStyle textStyle(Color color, [String? itemTitle]) {
    final bool isActive = color == AllColors.globalAppColor;
    return isActive
        ? tsb13.copyWith(color: AllColors.globalAppColor)
        : tsb13.copyWith(color: AllColors.darkBlue);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const GroupsTab(),
    const ActivityTab(),
    const ActivityTab(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GroupsProvider>(context, listen: false).loadGroups();
    });
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.group_add),
              title: const Text('New Group'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateGroupScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('New Expense'),
              onTap: () async {
                Navigator.pop(context);
                final groups = context.read<GroupsProvider>().groups;
                if (groups.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please create a group first'),
                    ),
                  );
                  return;
                }

                final selectedGroup = await showDialog<Group>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Select Group'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final group = groups[index];
                          return ListTile(
                            title: Text(group.name),
                            onTap: () => Navigator.pop(context, group),
                          );
                        },
                      ),
                    ),
                  ),
                );

                if (selectedGroup != null && context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateExpenseScreen(
                        group: selectedGroup,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.white,
      appBar: AppBar(
        title: const Text('Splitwise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: StyleProvider(
        style: CustomStyle(),
        child: ConvexAppBar(
          style: TabStyle.fixedCircle,
          backgroundColor: AllColors.whiteBase,
          color: AllColors.white.withOpacity(0.2),
          activeColor: AllColors.globalAppColor,
          elevation: 0,
          cornerRadius: 18.r,
          height: 90.h,
          curveSize: 100.sp,
          top: -30.h,
          items: [
            TabItem(
                icon: SvgPicture.asset(Assets.images.home02,
                    color: _selectedIndex == 0
                        ? AllColors.globalAppColor
                        : AllColors.darkBlue),
                title: 'Home'),
            TabItem(
                icon: SvgPicture.asset(Assets.images.activity,
                    color: _selectedIndex == 1
                        ? AllColors.globalAppColor
                        : AllColors.darkBlue),
                title: 'Activity'),
            TabItem(
              icon: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AllColors.globalAppColor,
                  boxShadow: [
                    BoxShadow(
                      color: AllColors.globalAppColor.withOpacity(0.9),
                      blurRadius: 12,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 32.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              title: '',
            ),
            TabItem(
                icon: SvgPicture.asset(Assets.images.friends,
                    color: _selectedIndex == 2
                        ? AllColors.globalAppColor
                        : AllColors.darkBlue),
                title: 'Friends'),
            TabItem(
                icon: SvgPicture.asset(Assets.images.profile,
                    color: _selectedIndex == 3
                        ? AllColors.globalAppColor
                        : AllColors.darkBlue),
                title: 'Profile'),
          ],
          initialActiveIndex: 0,
          onTap: (int index) {
            if (index == 2) {
              _showAddDialog();
              return;
            }
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
