import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  OutlineInputBorder _buildBorder({required Color color, double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (field) {
        final hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: (val) => field.didChange(val),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: hasError ? AllColors.red : AllColors.globalAppColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                enabledBorder: _buildBorder(
                  color: hasError ? AllColors.errorField : Colors.black12,
                ),
                focusedBorder: _buildBorder(
                  color: hasError
                      ? AllColors.errorField
                      : AllColors.globalAppColor,
                  width: 1.5,
                ),
                errorBorder:
                    _buildBorder(color: AllColors.errorField, width: 1.5),
                focusedErrorBorder:
                    _buildBorder(color: AllColors.errorField, width: 1.5),
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
            ),
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8),
                child: Row(
                  children: [
                    Icon(Icons.error_outline,
                        color: AllColors.red, size: 16.sp),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        field.errorText!,
                        style: tsb10.copyWith(color: AllColors.red),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
