import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/features/profile/data/model/profile_model.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/widget/add_expense_sheet_widget.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profile;
  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String selectedCurrency = "EGP";
  String selectedCountry = "Egypt";
  String selectedLanguage = "English";

  List<String> currencies = ["USD", "EUR", "GBP", "EGP"];
  List<String> countries = ["Australia", "Bahrain", "Canada", "Egypt"];
  List<String> languages = [
    "Français",
    "Deutsch",
    "English",
    "Chinese",
    "Hindi"
  ];
  double progress = 0.75;
  @override
  void initState() {
    final user = widget.profile.user;

    fullNameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
    phoneController.text = user?.phone ?? "";

    selectedCurrency = user?.currency?['name'] ?? "EGP";
    selectedCountry = user?.country?['name'] ?? "Egypt";
    selectedLanguage = user?.language ?? "English";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.editProfileInformation.tr(), style: tr20),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back, color: AllColors.grey),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AllColors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AllColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: (progress * 100).toInt(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AllColors.globalAppColor,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(2.r)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: ((1 - progress) * 100).toInt(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AllColors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(2.r)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    LocaleKeys.profileCompletionMessage.tr(),
                    style: tsb13,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    LocaleKeys.profileCompletionHint.tr(),
                    style: tr10.copyWith(color: AllColors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CircleAvatar(
              radius: 40.r,
              backgroundColor: AllColors.globalAppColor.withValues(alpha: 0.3),
              child: Text(
                widget.profile.user?.name?.isNotEmpty == true
                    ? widget.profile.user!.name![0]
                    : "?",
                style: tr20,
              ),
            ),
            SizedBox(height: 20.h),
            LabeledTextField(
              label: LocaleKeys.fullName.tr(),
              labelStyle: tr13,
              hint: LocaleKeys.enterFullName.tr(),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(
                  Assets.images.iconInterfaceOutline,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(
                  Assets.images.user05,
                ),
              ),
              controller: fullNameController,
            ),
            SizedBox(height: 16.h),
            LabeledTextField(
              label: LocaleKeys.email.tr(),
              labelStyle: tr13,
              hint: LocaleKeys.enterEmail.tr(),
              suffixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(
                  Assets.images.iconInterfaceOutline,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SvgPicture.asset(
                  Assets.images.mail01,
                ),
              ),
              controller: emailController,
            ),
            SizedBox(height: 16.h),
            LabeledPhoneField(
              label: LocaleKeys.phoneNumber.tr(),
              hint: LocaleKeys.enterPhoneNumber.tr(),
              controller: phoneController,
            ),
            SizedBox(height: 24.h),
            Divider(
              height: 0,
              color: AllColors.grey.withValues(alpha: 0.4),
            ),
            SizedBox(height: 24.h),
            Text(
              LocaleKeys.preferences.tr(),
              style: tr20,
            ),
            SizedBox(height: 20.h),
            CustomSearchDropdown(
              label: LocaleKeys.currency.tr(),
              value: selectedCurrency,
              items: currencies,
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                });
              },
              prefixIcon: SvgPicture.asset(
                Assets.images.currencyPound,
              ),
            ),
            SizedBox(height: 16.h),
            CustomSearchDropdown(
              label: LocaleKeys.country.tr(),
              value: selectedCountry,
              items: countries,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
              },
              prefixIcon: SvgPicture.asset(
                Assets.images.flag01,
              ),
            ),
            SizedBox(height: 16.h),
            CustomSearchDropdown(
              label: LocaleKeys.preferredLanguage.tr(),
              value: selectedLanguage,
              items: languages,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
              prefixIcon: SvgPicture.asset(
                Assets.images.globe02,
                width: 20.w,
                height: 20.h,
              ),
            ),
            SizedBox(height: 24),
            AppButton(
              text: LocaleKeys.save.tr(),
              onPressed: () {},
              color: AllColors.globalAppColor,
              icon: Icons.check,
              iconSize: 20.sp,
              textColor: AllColors.white,
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;

  const CustomSearchDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  State<CustomSearchDropdown> createState() => _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? "");
  }

  void _handleTap() async {
    final selected = await showSelectionDialog(
      context: context,
      title: widget.label,
      items: widget.items,
      selectedValue: _controller.text,
    );

    if (selected != null) {
      setState(() {
        _controller.text = selected;
      });
      widget.onChanged?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: tr13),
          SizedBox(height: 6),
          AbsorbPointer(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "${LocaleKeys.select.tr()} ${widget.label}",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                hintStyle:
                    tr16.copyWith(color: AllColors.grey.withOpacity(0.8)),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: widget.prefixIcon,
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SvgPicture.asset(Assets.images.edit05),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AllColors.grey, width: 0.2.w),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AllColors.grey, width: 0.2.w),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AllColors.red, width: 0.2.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

Future<String?> showSelectionDialog({
  required BuildContext context,
  required String title,
  required List<String> items,
  required String selectedValue,
}) async {
  TextEditingController searchController = TextEditingController();
  List<String> filteredItems = [...items];

  return showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("${LocaleKeys.select.tr()} $title", style: tr16),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, color: AllColors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Divider(color: AllColors.grey.withOpacity(0.5), height: 0),
                  SizedBox(height: 12),
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "${LocaleKeys.search.tr()} $title",
                      prefixIcon: Icon(Icons.search, color: AllColors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredItems = items
                            .where((item) => item
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final isSelected = item == selectedValue;
                        return ListTile(
                          title: Text(item),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (_) => Navigator.pop(context, item),
                            activeColor: AllColors.globalAppColor,
                          ),
                          onTap: () => Navigator.pop(context, item),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class LabeledPhoneField extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle? labelStyle;
  final TextEditingController? controller;

  const LabeledPhoneField({
    super.key,
    required this.label,
    required this.hint,
    this.labelStyle,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle ?? tr13),
        SizedBox(height: 6.h),
        IntlPhoneField(
          controller: controller,
          initialCountryCode: 'EG',
          decoration: InputDecoration(
            filled: true,
            fillColor: AllColors.grey.withOpacity(0.1),
            hintText: hint,
            contentPadding:
                EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            hintStyle: tr16.copyWith(color: AllColors.grey.withOpacity(0.8)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColors.grey, width: 0.2.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColors.grey, width: 0.2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColors.grey, width: 0.2.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColors.red, width: 0.2.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AllColors.red, width: 0.2.w),
            ),
          ),
          validator: (value) {
            if (value == null || value.number.isEmpty) {
              return LocaleKeys.enterValidPhoneNumber.tr();
            }
            return null;
          },
          onChanged: (phone) {
            log(phone.completeNumber);
          },
          onCountryChanged: (country) {
            log('Country changed to: ${country.name}');
          },
        )
      ],
    );
  }
}
