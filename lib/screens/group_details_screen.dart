import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/screens/expense_list_screen.dart';
import 'package:splitwise_flutter/widgets/balance_card_widget.dart';
import 'package:splitwise_flutter/widgets/expense_card_widget.dart';
import '../models/group.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';
import 'manage_members_screen.dart';

class GroupDetailsScreen extends StatefulWidget {
  final Group group;

  const GroupDetailsScreen({super.key, required this.group});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final _expenseService = ExpenseService();
  List<Expense> _expenses = [];
  Map<String, double> _balances = {};
  bool _isLoading = true;

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final expenses = await _expenseService.getGroupExpenses(widget.group.id);
      final balances = await _expenseService.getGroupBalances(widget.group.id);
      if (mounted) {
        setState(() {
          _expenses = expenses;
          _balances = balances;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: ${e.toString()}')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Column _buildBalanceTab() {
    return Column(
      children: [
        buildHeader("Balances",
            actionText: "Settle Up",
            onAction: () {},
            color: AllColors.globalAppColor,
            colorText: AllColors.white),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            children: [
              if (_balances.isNotEmpty)
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AllColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 0.4.w, color: Colors.grey.withOpacity(0.3)),
                  ),
                  child: const Text('No balance yet'),
                )
              else
                Column(
                  children: [
                    BalanceCard(
                      totalSpent: 400,
                      members: [
                        {"name": "You", "amount": 300},
                        {"name": "Ahmed", "amount": -100},
                        {"name": "Ali", "amount": -100},
                        {"name": "Hassan", "amount": -100},
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  ExpenseListScreen _buildExpensesTab() {
    return ExpenseListScreen(group: widget.group);
  }

  Column _buildStatisticsTab() {
    final Map<String, double> chartData = {
      'You': 55,
      'Ahmed': 15,
      'Ali': 15,
      'Hassan': 15,
    };
    return Column(
      children: [
        buildHeader("Charts",
            actionText: "Export",
            onAction: () {},
            color: AllColors.globalAppColor,
            colorText: AllColors.white,
            hasIcon: true,
            assetName: Assets.images.export),
        _expenses.isNotEmpty
            ? Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      width: 0.2, color: Colors.grey.withOpacity(0.3)),
                ),
                child: const Text('No expenses yet'),
              )
            : Expanded(
                child: ExpenseOverviewCard(
                  data: chartData,
                  total: 400,
                  selectedPerson: 'You',
                  onExport: () {},
                  onPersonChanged: (value) {},
                ),
              ),
      ],
    );
  }

  ManageMembersScreen _buildMembersTab() {
    return ManageMembersScreen(group: widget.group);
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildBalanceTab();
      case 1:
        return _buildExpensesTab();
      case 2:
        return _buildStatisticsTab();
      case 3:
        return _buildMembersTab();
      default:
        return _buildBalanceTab();
    }
  }

  Container _buildTopMenu() {
    final tabs = ['Balances', 'Expenses', 'Charts', 'Members'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1.2.w,
          color: AllColors.grey.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.4, color: AllColors.grey.withOpacity(0.4)),
                  color: isSelected
                      ? AllColors.globalAppColor.withOpacity(0.2)
                      : AllColors.transparent,
                  borderRadius: index == 0
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(12.r),
                          topLeft: Radius.circular(12.r))
                      : index == 3
                          ? BorderRadius.only(
                              bottomRight: Radius.circular(12.r),
                              topRight: Radius.circular(12.r))
                          : BorderRadius.circular(0),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: tr13,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 16.h),
                _buildTopMenu(),
                SizedBox(height: 16.h),
                Expanded(child: _buildBody()),
              ],
            ),
    );
  }
}

Padding buildHeader(
  String title, {
  String? actionText,
  VoidCallback? onAction,
  Color? color,
  Color? colorText,
  String? assetName,
  bool? hasIcon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: tr20),
        if (actionText != null)
          GestureDetector(
            onTap: onAction,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color: AllColors.globalAppColor.withOpacity(0.1))),
              child: Row(
                children: [
                  Text(
                    actionText,
                    style: tr13.copyWith(color: colorText),
                  ),
                  if (hasIcon == true)
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        SvgPicture.asset(assetName!),
                      ],
                    )
                ],
              ),
            ),
          ),
      ],
    ),
  );
}

// class GroupDetailsScreen extends StatefulWidget {
//   final Group group;

//   const GroupDetailsScreen({
//     super.key,
//     required this.group,
//   });

//   @override
//   State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
// }

// class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
//   final _expenseService = ExpenseService();
//   List<Expense> _expenses = [];
//   Map<String, double> _balances = {};
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     setState(() => _isLoading = true);
//     try {
//       final expenses = await _expenseService.getGroupExpenses(widget.group.id);
//       final balances = await _expenseService.getGroupBalances(widget.group.id);
//       if (mounted) {
//         setState(() {
//           _expenses = expenses;
//           _balances = balances;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to load data: ${e.toString()}')),
//         );
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Widget _buildBalanceCard() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Balances',
//                 style: tr20,
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                   decoration: BoxDecoration(
//                     color: AllColors.grey.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Text(
//                     "Settle Up",
//                     style:
//                         tr13.copyWith(color: AllColors.grey.withOpacity(0.7)),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           const SizedBox(height: 16),
//           if (_balances.isEmpty)
//             Container(
//                 alignment: Alignment.centerLeft,
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                 decoration: BoxDecoration(
//                     color: AllColors.grey.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20.r),
//                     border: Border.all(
//                         width: 0.2.w, color: AllColors.grey.withOpacity(0.3))),
//                 child: Text('No balances yet'))
//           else
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: _balances.length,
//               itemBuilder: (context, index) {
//                 final entry = _balances.entries.elementAt(index);
//                 final isPositive = entry.value >= 0;
//                 return ListTile(
//                   title: Text(entry.key),
//                   trailing: Text(
//                     '${isPositive ? '+' : ''}\$${entry.value.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       color: isPositive ? Colors.green : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildExpensesList() {
//     if (_expenses.isEmpty) {
//       return const Center(
//         child: Text('No expenses yet'),
//       );
//     }

//     return Column(
//       children: _expenses.map((expense) {
//         final date = expense.date;
//         final formattedDate =
//             '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

//         return Card(
//           margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//           child: ListTile(
//             title: Text(
//               expense.description,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//             subtitle: Text(
//               'Paid by ${expense.paidBy.name} • $formattedDate',
//             ),
//             trailing: Text(
//               '\$${expense.amount.toStringAsFixed(2)}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             onTap: () {
//               // Show expense details in a bottom sheet
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) => Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         expense.description,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text('Paid by ${expense.paidBy.name}'),
//                       Text('Date: $formattedDate'),
//                       Text('Amount: \$${expense.amount.toStringAsFixed(2)}'),
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Splits',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       ...expense.splits.map((split) => ListTile(
//                             title: Text(split.user.name),
//                             trailing:
//                                 Text('\$${split.amount.toStringAsFixed(2)}'),
//                             dense: true,
//                           )),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.group.name),
//       //   actions: [
//       //     IconButton(
//       //       icon: const Icon(Icons.bar_chart),
//       //       onPressed: () => Navigator.push(
//       //         context,
//       //         MaterialPageRoute(
//       //           builder: (context) => GroupStatisticsScreen(group: widget.group),
//       //         ),
//       //       ),
//       //     ),
//       //     IconButton(
//       //       icon: const Icon(Icons.group),
//       //       onPressed: () async {
//       //         final result = await Navigator.push(
//       //           context,
//       //           MaterialPageRoute(
//       //             builder: (context) => ManageMembersScreen(group: widget.group),
//       //           ),
//       //         );
//       //         if (result == true) {
//       //           _loadData(); // Refresh data after managing members
//       //         }
//       //       },
//       //     ),
//       //   ],
//       // ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : RefreshIndicator(
//               onRefresh: _loadData,
//               child: ListView(
//                 children: [
//                   _buildBalanceCard(),
//                   // const Padding(
//                   //   padding: EdgeInsets.all(16.0),
//                   //   child: Text(
//                   //     'Expenses',
//                   //     style: TextStyle(
//                   //       fontSize: 18,
//                   //       fontWeight: FontWeight.bold,
//                   //     ),
//                   //   ),
//                   // ),
//                   // _buildExpensesList(),
//                 ],
//               ),
//             ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () async {
//       //     final result = await Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => CreateExpenseScreen(group: widget.group),
//       //       ),
//       //     );
//       //     if (result == true) {
//       //       _loadData(); // Refresh data after creating expense
//       //     }
//       //   },
//       //   child: const Icon(Icons.add),
//       // ),
//     );
//   }
// }
