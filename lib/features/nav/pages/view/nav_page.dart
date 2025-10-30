import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/dependencies/dependency_init.dart';
import 'package:splitwise_flutter/core/functions/app_alert_dialog.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/app_routes.dart';
import 'package:splitwise_flutter/core/utilities/routes_navigator/navigator.dart';
import 'package:splitwise_flutter/features/authentication/logic/authentication_cubit.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_text_field_widget.dart';
import 'package:splitwise_flutter/features/home/data/model/create_group/create_group_model.dart';
import 'package:splitwise_flutter/features/home/data/model/groups/group.dart';
import 'package:splitwise_flutter/features/home/data/model/update_groups/update_groups_model.dart';
import 'package:splitwise_flutter/features/home/data/repositories/group_repository.dart';
import 'package:splitwise_flutter/features/home/logic/groups_cubit.dart';
import 'package:splitwise_flutter/features/nav/domain/entity/nav_entity.dart';
import 'package:splitwise_flutter/features/nav/logic/nav_cubit.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/widget/searsh_friendes_dialog_widget.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  final AuthenticationCubit _authenticationCubit = getIt<AuthenticationCubit>();

  bool isCreating = false;

  static const int createIndex = 2;
  static const int homeIndex = 0;
  final GroupsCubit _groupsCubit = getIt<GroupsCubit>();

  void _showUpdateDialog(GroupModel group) {
    final nameController = TextEditingController(text: group.name);
    int selectedCategoryId = group.categoryId ?? 1;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(LocaleKeys.editGroup.tr(), style: tr20),
              SizedBox(height: 16.h),
              AppTextField(
                controller: nameController,
                label: LocaleKeys.groupName.tr(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return LocaleKeys.groupNameValidation.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: 16.h),
              // DropdownButtonFormField<int>(
              //   value: selectedCategoryId,
              //   decoration: InputDecoration(
              //     labelText: LocaleKeys.category.tr(),
              //     border: OutlineInputBorder(),
              //   ),
              //   items: List.generate(8, (index) {
              //     final id = index + 1;
              //     return DropdownMenuItem(
              //       value: id,
              //       child: Text("${LocaleKeys.category.tr()} $id"),
              //     );
              //   }),
              //   onChanged: (value) {
              //     if (value != null) selectedCategoryId = value;
              //   },
              // ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    text: LocaleKeys.cancel.tr(),
                    color: AllColors.grey.withOpacity(0.2),
                    textColor: AllColors.black,
                    onPressed: () => Navigator.pop(context),
                    width: 100.w,
                  ),
                  BlocListener<GroupsCubit, GroupsState>(
                    bloc: _groupsCubit,
                    listener: (context, state) {
                      if (state.successMessage != null) {
                        AppAlertDialog.showSuccessBar(
                            message: state.successMessage);
                      }
                      if (state.errorMessage != null) {
                        AppAlertDialog.showErrorBar(
                            errorMessage: state.errorMessage!);
                      }
                    },
                    child: AppButton(
                      text: LocaleKeys.edit.tr(),
                      color: AllColors.globalAppColor,
                      textColor: AllColors.white,
                      onPressed: () {
                        Navigator.pop(context);
                        final updatedModel = UpdateGroupsModel(
                          name: nameController.text.trim(),
                          description: "selectedCategoryId",
                        );
                        getIt<GroupsCubit>()
                            .updateGroup(group.id!, updatedModel);
                      },
                      width: 100.w,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(GroupModel group) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: LocaleKeys.delete.tr(),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300.w,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AllColors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: SvgPicture.asset(Assets.images.logOutDialog)),
                  SizedBox(height: 16.h),
                  Text(
                    "${LocaleKeys.delete.tr()} ${LocaleKeys.group.tr()} ${group.name} ?",
                    style: tr16.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        text: LocaleKeys.cancel.tr(),
                        color: AllColors.grey.withOpacity(0.2),
                        textColor: AllColors.black,
                        onPressed: () => Navigator.pop(context),
                        width: 100.w,
                      ),
                      AppButton(
                        text: LocaleKeys.delete.tr(),
                        color: AllColors.globalAppColor,
                        textColor: AllColors.white,
                        onPressed: () {
                          Navigator.pop(context);
                          _handleDeleteGroup(group);
                        },
                        width: 100.w,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return Transform.scale(
          scale: anim.value,
          child: Opacity(opacity: anim.value, child: child),
        );
      },
    );
  }

  void _handleDeleteGroup(GroupModel group) async {
    await _groupsCubit.deleteGroup(group.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(GroupRepository(getIt())),
      child: BlocBuilder<NavCubit, NavState>(
        builder: (context, state) {
          if (state.currentIndex != createIndex && isCreating) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => isCreating = false);
            });
          } else if (state.currentIndex == createIndex && !isCreating) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => isCreating = true);
            });
          }

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  if (state.isDetailsPage) ...[
                    if (state.appBarIcon != null)
                      SvgPicture.asset(
                        state.appBarIcon!,
                        width: 28.w,
                        height: 28.h,
                      ),
                    SizedBox(width: 8.w),
                    Expanded(
                        child: Text(state.appBarTitle ?? "", style: tsb20)),
                    const Spacer(),
                    PopupMenuButton<String>(
                      icon: SvgPicture.asset(Assets.images.setting2),
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showUpdateDialog(state.selectedGroup!);
                        } else if (value == 'delete') {
                          _showDeleteDialog(state.selectedGroup!);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: AllColors.globalAppColor),
                              SizedBox(width: 8.w),
                              Text("edit"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: AllColors.error),
                              SizedBox(width: 8.w),
                              Text(LocaleKeys.delete.tr()),
                            ],
                          ),
                        ),
                      ],
                    ),
                    12.w.horizontalSpace,
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 24.h),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(LocaleKeys.shareGroup.tr(),
                                              style: tr20),
                                          GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: const Icon(Icons.close,
                                                color: AllColors.grey),
                                          ),
                                        ],
                                      ),
                                      12.h.verticalSpace,
                                      Divider(
                                        height: 0,
                                        color: AllColors.grey
                                            .withValues(alpha: 0.2),
                                      ),
                                      24.h.verticalSpace,
                                      _contantShareDialog(Assets.images.shareCq,
                                          LocaleKeys.shareQrCode.tr()),
                                      _contantShareDialog(
                                          Assets.images.shareCopyLink,
                                          LocaleKeys.shareGroupLink.tr()),
                                    ]),
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(Assets.images.share)),
                  ] else ...[
                    Image.asset(
                      Assets.images.iconInterfaceSolid.path,
                      width: 35.w,
                      height: 35.h,
                      color: AllColors.globalAppColor,
                    ),
                    SizedBox(width: 8.w),
                    Text(state.appBarTitle ?? "", style: tsb20),
                    const Spacer(),
                    if (state.currentIndex != 4)
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => const SearchFriendsDialog());
                          },
                          child: SvgPicture.asset(Assets.images.searsh)),
                  ],
                ],
              ),
            ),
            body: state.currentPage?.page,
            bottomNavigationBar: SizedBox(
              height: 90.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const NavBarBackground(),
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(state.navPages.length, (index) {
                        final item = state.navPages[index];
                        final isSelected = state.currentIndex == index;

                        if (index == createIndex) {
                          return Row(
                            children: [
                              SizedBox(width: 60.w),
                              _buildNavItem(context, item, index, isSelected),
                            ],
                          );
                        }

                        return _buildNavItem(context, item, index, isSelected);
                      }),
                    ),
                  ),
                  Positioned(
                    top: -25.h,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _onMiddleButtonPressed(context, state),
                      child: Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: AllColors.globalAppColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AllColors.globalAppColor.withOpacity(0.6),
                              blurRadius: 10.r,
                              spreadRadius: 3.r,
                              offset: const Offset(0, 1),
                            )
                          ],
                        ),
                        child: Icon(
                          (isCreating || state.currentIndex == createIndex)
                              ? Icons.check
                              : Icons.add,
                          color: Colors.white,
                          size: 32.h,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _contantShareDialog(String icon, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AllColors.grey.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 8.w),
          Text(description, style: tr16),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavEntity item,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        if (index == createIndex) {
          context.read<NavCubit>().changePage(createIndex);

          setState(() => isCreating = true);
          return;
        }
        context.read<NavCubit>().resetAppBarToHome();

        context.read<NavCubit>().changePage(index);
        if (isCreating) setState(() => isCreating = false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(item.icon,
              color: isSelected ? AllColors.globalAppColor : AllColors.grey),
          Text(item.title,
              style: tr13.copyWith(
                color: isSelected ? AllColors.globalAppColor : AllColors.grey,
              )),
        ],
      ),
    );
  }

  void _onMiddleButtonPressed(BuildContext context, NavState state) {
    if (state.currentIndex == 2) {
      context
          .read<NavCubit>()
          .requestCreateGroup(state.createdGroup ?? CreateGroupModel());
    } else {
      context.read<NavCubit>().changePage(2);
    }
  }

  void _handleEditGroup(NavState state) {
    final group = state.selectedGroup;
    if (group != null) {}
  }
}

class NavBarBackground extends StatelessWidget {
  const NavBarBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width, 90),
      painter: _NavBarPainter(),
    );
  }
}

class _NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AllColors.whiteBase
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 20)
      ..quadraticBezierTo(size.width * 0.05, 0, size.width * 0.15, 0)
      ..lineTo(size.width * 0.37, 0)
      ..quadraticBezierTo(
        size.width * 0.5,
        -65,
        size.width * 0.63,
        0,
      )
      ..lineTo(size.width * 0.85, 0)
      ..quadraticBezierTo(size.width * 0.95, 0, size.width, 20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 6, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
