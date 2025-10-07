import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileQrCoodScreen extends StatefulWidget {
  const ProfileQrCoodScreen({super.key});

  @override
  State<ProfileQrCoodScreen> createState() => _ProfileQrCoodScreenState();
}

int selectIndex = 0;

class _ProfileQrCoodScreenState extends State<ProfileQrCoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectIndex == 0
              ? LocaleKeys.qrCode.tr()
              : LocaleKeys.scanningQrCode.tr(),
          style: tr20,
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back, color: AllColors.grey),
        ),
      ),
      body: Column(
        children: [
          buildSwitchRow(
            selectedIndex: selectIndex,
            onSelect: (index) {
              setState(() {
                selectIndex = index;
              });
            },
          ),
          SizedBox(height: 24.h),
          if (selectIndex == 0)
            QrImageView(
              data: "youssef_unique_user_id_or_email@example.com",
              version: QrVersions.auto,
              size: 350.w,
              backgroundColor: Colors.white,
            ),
          if (selectIndex == 1)
            SizedBox(
              height: 400.h,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      child: MobileScanner(
                        fit: BoxFit.cover,
                        onDetect: (capture) {
                          final barcode = capture.barcodes.first;
                          final code = barcode.rawValue;
                          if (code != null) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${LocaleKeys.scannedQrCode.tr()}: $code',
                                ),
                                backgroundColor: AllColors.globalAppColor,
                              ),
                            );
                            setState(() => selectIndex = 0);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget buildSwitchRow({
    required int selectedIndex,
    required Function(int) onSelect,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Row(
        children: List.generate(2, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.6,
                    color: isSelected
                        ? AllColors.globalAppColor.withOpacity(0.1)
                        : AllColors.grey.withOpacity(0.5),
                  ),
                  color: isSelected
                      ? AllColors.globalAppColor.withOpacity(0.2)
                      : AllColors.transparent,
                  borderRadius: index == 0
                      ? BorderRadiusDirectional.only(
                          topStart: Radius.circular(12.r),
                          bottomStart: Radius.circular(12.r),
                        )
                      : BorderRadiusDirectional.only(
                          topEnd: Radius.circular(12.r),
                          bottomEnd: Radius.circular(12.r),
                        ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      index == 0
                          ? Assets.images.qrCode01
                          : Assets.images.maximize02,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      index == 0
                          ? LocaleKeys.qrCode.tr()
                          : LocaleKeys.scanningQrCode.tr(),
                      style: tr12,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
