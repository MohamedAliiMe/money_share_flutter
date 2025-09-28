import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import '../models/group.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';
import 'create_expense_screen.dart';
import 'manage_members_screen.dart';
import 'group_statistics_screen.dart';

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

  Widget _buildBalanceTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Balances',
                style: tr20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AllColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "Settle Up",
                    style:
                        tr13.copyWith(color: AllColors.grey.withOpacity(0.7)),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_balances.isEmpty)
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AllColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 0.2, color: AllColors.grey.withOpacity(0.3)),
                  ),
                  child: const Text('No balances yet'),
                )
              else
                Column(
                  children: _balances.entries.map((entry) {
                    final isPositive = entry.value >= 0;
                    return ListTile(
                      title: Text(entry.key),
                      trailing: Text(
                        '${isPositive ? '+' : ''}\$${entry.value.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpensesTab() {
    return _expenses.isEmpty
        ? const Center(child: Text('No expenses yet'))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: _expenses.map((expense) {
              final date = expense.date;
              final formattedDate =
                  '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(expense.description),
                  subtitle:
                      Text('Paid by ${expense.paidBy.name} • $formattedDate'),
                  trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
                ),
              );
            }).toList(),
          );
  }

  Widget _buildStatisticsTab() {
    return GroupStatisticsScreen(group: widget.group);
  }

  Widget _buildMembersTab() {
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

  Widget _buildTopMenu() {
    final tabs = ['Balances', 'Expenses', 'Statistics', 'Members'];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AllColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 1.w,
          color: AllColors.black.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 1.w,
              height: 40.h,
              color: AllColors.grey.withOpacity(0.4),
            );
          }

          int index = i ~/ 2;
          final isSelected = _selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                color: isSelected
                    ? AllColors.globalAppColor.withOpacity(0.2)
                    : Colors.transparent,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? AllColors.globalAppColor : Colors.black,
                    fontWeight: FontWeight.bold,
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
                SizedBox(height: 16),
                _buildTopMenu(),
                const SizedBox(height: 16),
                Expanded(child: _buildBody()),
              ],
            ),
    );
  }
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
