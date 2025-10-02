import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/models/activity.dart';
import 'package:splitwise_flutter/widgets/activity_card_widget.dart';
import '../providers/expense_provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<ActivityModel> _activities = [
    ActivityModel(
      id: 1,
      description: "Dinner",
      type: "expense",
      createdAt: DateTime.now(),
      amount: 400,
      groupId: 1,
      groupName: "Hurghada",
      userId: 1,
      userName: "You",
    ),
    ActivityModel(
      id: 2,
      description: "Rent",
      type: "expense",
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      amount: -250,
      groupId: 2,
      groupName: "Apartment",
      userId: 2,
      userName: "Omar",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _activities.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.images.noActivityHere.path),
                  SizedBox(height: 16.h),
                  Text("No Activity Here Yet", style: tr13),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Text("Groups", style: tr20),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _activities.length,
                    itemBuilder: (context, index) {
                      return ActivityCard(activity: _activities[index]);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
