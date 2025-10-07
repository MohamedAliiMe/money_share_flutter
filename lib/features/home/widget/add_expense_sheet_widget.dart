import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AddExpenseSheet extends StatelessWidget {
  const AddExpenseSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(LocaleKeys.addExpense.tr(), style: tr20),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: AllColors.grey.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            16.h.verticalSpace,
            Divider(height: 0, color: AllColors.grey.withValues(alpha: 0.5)),
            24.h.verticalSpace,
            LabeledTextField(
              label: LocaleKeys.description.tr(),
              hint: LocaleKeys.descriptionHint.tr(),
              prefixIcon: SvgPicture.asset(
                Assets.images.messageText,
                fit: BoxFit.scaleDown,
              ),
            ),
            12.h.verticalSpace,
            LabeledDropdown(
              label: LocaleKeys.currency.tr(),
              value: "EGP",
              items: ["EGP", "USD", "EUR"],
              onChanged: (_) {},
              prefixIcon: SvgPicture.asset(
                Assets.images.currencyPound,
                fit: BoxFit.scaleDown,
              ),
            ),
            12.h.verticalSpace,
            LabeledTextField(
              label: LocaleKeys.amount.tr(),
              hint: LocaleKeys.amountHint.tr(),
              keyboardType: TextInputType.number,
              prefixIcon: SvgPicture.asset(
                Assets.images.moneys,
                fit: BoxFit.scaleDown,
              ),
            ),
            12.h.verticalSpace,
            LabeledDropdown(
              label: LocaleKeys.paidBy.tr(),
              value: "You",
              items: ["You", "Ahmed", "Ali", "Hassan"],
              onChanged: (_) {},
              prefixIcon: SvgPicture.asset(
                Assets.images.userTick,
                fit: BoxFit.scaleDown,
              ),
            ),
            16.h.verticalSpace,
            Row(
              children: [
                buildCustomButton(
                  title: LocaleKeys.equalSplit.tr(),
                  backgroundColor: AllColors.white.withOpacity(0.2),
                  textColor: AllColors.black,
                  borderColor: AllColors.grey.withValues(alpha: 0.3),
                  onTap: () {},
                ),
                12.w.horizontalSpace,
                buildCustomButton(
                  title: LocaleKeys.customSplit.tr(),
                  backgroundColor:
                      AllColors.globalAppColor.withValues(alpha: 0.2),
                  textColor: AllColors.black,
                  borderColor: AllColors.globalAppColor.withValues(alpha: 0.2),
                  onTap: () {},
                ),
              ],
            ),
            16.h.verticalSpace,
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AllColors.grey.withOpacity(0.4)),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _splitRow("You", "30%"),
                  _splitRow("Ahmed", "30%"),
                  _splitRow("Ali", "30%"),
                  _splitRow("Hassan", "10%"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _splitRow(String name, String percent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: tr16),
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AllColors.grey.withValues(alpha: 0.7), width: 0.7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(percent, style: tr16),
          ),
        ],
      ),
    );
  }

  Expanded buildCustomButton({
    required String title,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: borderColor, width: 0.7.w),
          ),
          alignment: Alignment.center,
          child: Text(title, style: tr13.copyWith(color: textColor)),
        ),
      ),
    );
  }
}

  Container _splitRow(String name, String percent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: tr16),
          Container(
            margin: EdgeInsets.only(bottom: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: AllColors.grey.withValues(alpha: 0.7), width: 0.7),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(percent, style: tr16),
          ),
        ],
      ),
    );
  }

  Expanded buildCustomButton({
    required String title,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: borderColor, width: 0.7.w)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: tr13.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }


class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.labelStyle,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle ?? tsb13),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            hintStyle: tr16.copyWith(color: AllColors.grey.withOpacity(0.8)),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
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
      ],
    );
  }
}

class LabeledDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final Widget? prefixIcon;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    this.onChanged,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: tsb13),
        6.h.verticalSpace,
        DropdownButtonFormField<String>(
          style: tr16,
          value: value,
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
            prefixIcon: prefixIcon,
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
        )
      ],
    );
  }
}
