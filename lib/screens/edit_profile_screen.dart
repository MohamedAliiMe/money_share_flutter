import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/widget/app_button_widget.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/widgets/add_expense_sheet_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fullNameController =
      TextEditingController(text: "Mohamed Ahmed");
  TextEditingController emailController =
      TextEditingController(text: "mohamedahmed@gmail.com");
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile Information", style: tr20),
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
                    "Need 20% more to complete your profile.",
                    style: tsb13,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Add a few more details to complete your profile.",
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
                "M",
                style: tr20,
              ),
            ),
            SizedBox(height: 20.h),
            LabeledTextField(
              label: "Full Name",
              labelStyle: tr13,
              hint: "Enter your full name",
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
              label: "Email",
              labelStyle: tr13,
              hint: "Enter your email",
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
                label: "Phone Number",
                hint: "Enter your phone number",
                controller: phoneController),
            SizedBox(height: 24.h),
            Divider(
              height: 0,
              color: AllColors.grey.withValues(alpha: 0.4),
            ),
            SizedBox(height: 24.h),
            Text(
              "Preferences",
              style: tr20,
            ),
            SizedBox(height: 20.h),
            CustomSearchDropdown(
              label: "Currency",
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
              label: "Country",
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
              label: "Preferred Language ( for emails )",
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
              text: "Save",
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
  _CustomSearchDropdownState createState() => _CustomSearchDropdownState();
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
                hintText: "Select ${widget.label}",
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
                      Text("Select $title", style: tr16),
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
                      hintText: "Search $title",
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
              return "Enter a valid phone number";
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
