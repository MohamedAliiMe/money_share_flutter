import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitwise_flutter/core/utilities/configs/app_typography.dart';
import 'package:splitwise_flutter/core/utilities/configs/colors.dart';
import 'package:splitwise_flutter/gen/assets.gen.dart';
import 'package:splitwise_flutter/features/home/domain/model/user.dart';
import 'package:splitwise_flutter/features/home/pages/group_details_screen.dart';
import 'package:splitwise_flutter/features/home/widget/add_expense_sheet_widget.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import '../../../models/expense.dart';
import '../domain/model/group.dart';

class ExpenseListScreen extends StatefulWidget {
  final GroupModel group;

  const ExpenseListScreen({super.key, required this.group});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  final List<Expense> _expenses = [
    Expense(
      groupId: 1,
      id: 1,
      paidBy: UserModel(id: 1, name: "name", email: "email"),
      splits: [],
      description: 'Dinner with friends',
      amount: 250.75,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  void _openAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddExpenseSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildHeader(
          LocaleKeys.expenses.tr(),
          actionText: LocaleKeys.addExpense.tr(),
          onAction: _openAddExpenseSheet,
          color: AllColors.globalAppColor,
          colorText: AllColors.white,
        ),
        if (_expenses.isEmpty)
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AllColors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                width: 0.2.w,
                color: AllColors.grey.withOpacity(0.3),
              ),
            ),
            child: Text(LocaleKeys.noExpensesYet.tr(), style: tr16),
          ),
        if (_expenses.isNotEmpty)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
                return ExpenseListItem(expense: expense);
              },
            ),
          )
      ],
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  final Expense expense;

  const ExpenseListItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final date = expense.date;
    final formattedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    return Card(
      color: AllColors.grey.withValues(alpha: 0.09),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(
          color: AllColors.grey.withValues(alpha: 0.4),
          width: 0.7.w,
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    expense.description,
                    style: tr16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('\$${expense.amount.toStringAsFixed(2)}', style: tr16),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                SvgPicture.asset(Assets.images.user04),
                4.w.horizontalSpace,
                Text(
                  '${LocaleKeys.paidBy.tr()} ${expense.paidBy.name}',
                  style: tr13,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                SvgPicture.asset(Assets.images.calendarExpnses),
                4.w.horizontalSpace,
                Text(formattedDate, style: tr13),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
