import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/features/authentication/data/models/user_model/usermodel.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/pages/group_details_screen.dart';
import 'package:splitwise_flutter/features/home/widget/searsh_friendes_dialog_widget.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:splitwise_flutter/translations/locale_keys.g.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  List _friends = [];
  int selectedIndex = 0;

  final List<String> tabs = ["QR Code", "Email"];
  final List<UserModel> _dummyMembers = [
    UserModel(id: 1, name: "You", email: "mohamed@gmail.com"),
    UserModel(id: 2, name: "Ahmed", email: "ahmed@gmail.com"),
    UserModel(id: 3, name: "Ali", email: "ali@gmail.com"),
    UserModel(id: 4, name: "Hassan", email: "hassan@gmail.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(
            LocaleKeys.friends.tr(),
            actionText: LocaleKeys.addFriend.tr(),
            onAction: _showAddFriendDialog,
            color: AllColors.white,
            colorText: AllColors.black,
            hasIcon: true,
            assetName: Assets.images.add,
          ),
          Expanded(
            child: _dummyMembers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.images.noFriends.path),
                        SizedBox(height: 18.h),
                        Text(LocaleKeys.noFriendsYet.tr(), style: tr13),
                      ],
                    ),
                  )
                : ListView(
                    children: [
                      ..._dummyMembers.map(
                        (member) => Card(
                          elevation: 0,
                          color: AllColors.white.withOpacity(0.1),
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  AllColors.globalAppColor.withOpacity(0.2),
                              child: Text(
                                member.name?[0] ?? '',
                                style: tr20,
                              ),
                            ),
                            title: Text(
                              member.name ?? '',
                              style: tr20,
                            ),
                            subtitle: Text(
                              member.email ?? '',
                              style: tr13.copyWith(
                                  color: AllColors.grey.withOpacity(0.9)),
                            ),
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

  void _showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: StatefulBuilder(
          builder: (context, setDialogState) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.addFriend.tr(), style: tr20),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: AllColors.grey),
                      ),
                    ],
                  ),
                  12.h.verticalSpace,
                  Divider(
                    height: 0,
                    color: AllColors.grey.withOpacity(0.2),
                  ),
                  24.h.verticalSpace,
                  buildSwitchRow(
                    selectedIndex: selectedIndex,
                    onSelect: (index) {
                      setDialogState(() {
                        selectedIndex = index;
                      });

                      if (index == 1) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          _openQRScanner(setDialogState);
                        });
                      }
                    },
                  ),
                  24.h.verticalSpace,
                  if (selectedIndex == 0)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _showMyQRCode(context),
                          child: _contantAddFriendsDialog(
                            Assets.images.shareCq,
                            LocaleKeys.scanQrCode.tr(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (_) => SearchFriendsDialog(
                                title: LocaleKeys.searchByEmail.tr(),
                                hintText: LocaleKeys.email.tr(),
                                imagePath: Assets.images.send01,
                                textButton: LocaleKeys.sendRequest.tr(),
                              ),
                            );
                          },
                          child: _contantAddFriendsDialog(
                            Assets.images.email,
                            LocaleKeys.searchByEmail.tr(),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showMyQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(LocaleKeys.myQrCode.tr(), style: tr20),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AllColors.grey),
                  ),
                ],
              ),
              24.h.verticalSpace,
              Divider(height: 0, color: AllColors.grey.withOpacity(0.2)),
              32.h.verticalSpace,
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AllColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AllColors.black,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: "youssef_unique_user_id_or_email@example.com",
                  version: QrVersions.auto,
                  size: 200.w,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                LocaleKeys.qrCodeShareHint.tr(),
                style: tr10,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final qrPainter = QrPainter(
                        data: "youssef_unique_user_id_or_email@example.com",
                        version: QrVersions.auto,
                      );
                      final image = await qrPainter.toImage(300);
                      final byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      final buffer = byteData!.buffer.asUint8List();

                      final directory = await getTemporaryDirectory();
                      final file = await File('${directory.path}/qr_code.png')
                          .writeAsBytes(buffer);

                      await Share.shareXFiles(
                        [XFile(file.path)],
                        text: LocaleKeys.scanMyQrCode.tr(),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AllColors.globalAppColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Text(LocaleKeys.save.tr(),
                              style: tr13.copyWith(color: Colors.white)),
                          SizedBox(width: 8.w),
                          SvgPicture.asset(Assets.images.download02)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () async {
                      final qrPainter = QrPainter(
                        data: "youssef_unique_user_id_or_email@example.com",
                        version: QrVersions.auto,
                      );
                      final image = await qrPainter.toImage(300);
                      final byteData =
                          await image.toByteData(format: ImageByteFormat.png);
                      final buffer = byteData!.buffer.asUint8List();

                      final directory =
                          await getApplicationDocumentsDirectory();
                      final file =
                          await File('${directory.path}/my_qr_code.png')
                              .writeAsBytes(buffer);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(LocaleKeys.qrCodeSaved.tr()),
                          backgroundColor: AllColors.green,
                        ),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AllColors.globalAppColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Text(LocaleKeys.share.tr(),
                              style: tr13.copyWith(color: AllColors.white)),
                          SizedBox(width: 8.w),
                          SvgPicture.asset(
                            Assets.images.share,
                            width: 23.w,
                            height: 23.h,
                            color: AllColors.white,
                          )
                        ],
                      ),
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

  void _openQRScanner(StateSetter setDialogState) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: SizedBox(
          height: 400.h,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.scanQrCode.tr(), style: tr20),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: AllColors.grey),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
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
                            content:
                                Text('${LocaleKeys.scannedQrCode.tr()}: $code'),
                            backgroundColor: AllColors.globalAppColor,
                          ),
                        );
                        setDialogState(() => selectedIndex = 0);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSwitchRow({
    required int selectedIndex,
    required Function(int) onSelect,
  }) {
    return Row(
      children: List.generate(tabs.length, (index) {
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
                  Text(tabs[index], style: tr13),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container _contantAddFriendsDialog(String icon, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AllColors.grey.withOpacity(0.3),
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
}


































// class MobileQrScannerScreen extends StatelessWidget {
//   const MobileQrScannerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Scan QR Code")),
//       body: MobileScanner(
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           for (final barcode in barcodes) {
//             final String? code = barcode.rawValue;
//             if (code != null) {
//               Navigator.pop(context, code); 
//               break;
//             }
//           }
//         },
//       ),
//     );
//   }
// }









    //   return Consumer<ActivityProvider>(
    //     builder: (context, activityProvider, child) {
    //       if (activityProvider.isLoading) {
    //         return const Center(child: CircularProgressIndicator());
    //       }

    //       if (activityProvider.error != null) {
    //         return Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Icon(Icons.error_outline, size: 48, color: Colors.red),
    //               const SizedBox(height: 16),
    //               Text(activityProvider.error!),
    //               const SizedBox(height: 16),
    //               ElevatedButton(
    //                 onPressed: () => activityProvider.fetchActivities(),
    //                 child: const Text('Retry'),
    //               ),
    //             ],
    //           ),
    //         );
    //       }

    //       if (activityProvider.activities.isEmpty) {
    //         return const Center(
    //           child: Text('No activities yet'),
    //         );
    //       }

    //       return RefreshIndicator(
    //         onRefresh: () => activityProvider.fetchActivities(),
    //         child: ListView.builder(
    //           itemCount: activityProvider.activities.length,
    //           itemBuilder: (context, index) {
    //             final activity = activityProvider.activities[index];
    //             return ListTile(
    //               leading: CircleAvatar(
    //                 backgroundColor: _getActivityColor(activity.type),
    //                 child: Icon(_getActivityIcon(activity.type)),
    //               ),
    //               title: Text(activity.description),
    //               subtitle: Text(
    //                 '${activity.groupName} • ${DateFormat.yMMMd().format(activity.createdAt)}',
    //               ),
    //               trailing: Text(
    //                 '${activity.amount >= 0 ? '+' : ''}${activity.amount.toStringAsFixed(2)}',
    //                 style: TextStyle(
    //                   color: activity.amount >= 0 ? Colors.green : Colors.red,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //     },
    //   );
    // }

    // Color _getActivityColor(String type) {
    //   switch (type.toLowerCase()) {
    //     case 'expense':
    //       return Colors.red[100]!;
    //     case 'payment':
    //       return Colors.green[100]!;
    //     case 'settlement':
    //       return Colors.blue[100]!;
    //     default:
    //       return Colors.grey[100]!;
    //   }
    // }

    // IconData _getActivityIcon(String type) {
    //   switch (type.toLowerCase()) {
    //     case 'expense':
    //       return Icons.shopping_cart;
    //     case 'payment':
    //       return Icons.payment;
    //     case 'settlement':
    //       return Icons.account_balance;
    //     default:
    //       return Icons.history;
    //   }
    // }    return Scaffold(
//   }
// }
