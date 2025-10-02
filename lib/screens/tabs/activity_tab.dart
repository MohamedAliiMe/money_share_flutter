import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/activity_provider.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
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
  }
}
