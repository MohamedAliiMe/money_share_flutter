import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/expense.dart';
import '../services/expense_service.dart';
import 'create_expense_screen.dart';
import 'manage_members_screen.dart';
import 'group_statistics_screen.dart';

class GroupDetailsScreen extends StatefulWidget {
  final Group group;

  const GroupDetailsScreen({
    super.key,
    required this.group,
  });

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final _expenseService = ExpenseService();
  List<Expense> _expenses = [];
  Map<String, double> _balances = {};
  bool _isLoading = true;

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

  Widget _buildBalanceCard() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Balances',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_balances.isEmpty)
              const Text('No balances yet')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _balances.length,
                itemBuilder: (context, index) {
                  final entry = _balances.entries.elementAt(index);
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
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesList() {
    if (_expenses.isEmpty) {
      return const Center(
        child: Text('No expenses yet'),
      );
    }

    return Column(
      children: _expenses.map((expense) {
        final date = expense.date;
        final formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ListTile(
            title: Text(
              expense.description,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Paid by ${expense.paidBy.name} • $formattedDate',
            ),
            trailing: Text(
              '\$${expense.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () {
              // Show expense details in a bottom sheet
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        expense.description,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Paid by ${expense.paidBy.name}'),
                      Text('Date: $formattedDate'),
                      Text('Amount: \$${expense.amount.toStringAsFixed(2)}'),
                      const SizedBox(height: 16),
                      const Text(
                        'Splits',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...expense.splits.map((split) => ListTile(
                        title: Text(split.user.name),
                        trailing: Text('\$${split.amount.toStringAsFixed(2)}'),
                        dense: true,
                      )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupStatisticsScreen(group: widget.group),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.group),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageMembersScreen(group: widget.group),
                ),
              );
              if (result == true) {
                _loadData(); // Refresh data after managing members
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: ListView(
                children: [
                  _buildBalanceCard(),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Expenses',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildExpensesList(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateExpenseScreen(group: widget.group),
            ),
          );
          if (result == true) {
            _loadData(); // Refresh data after creating expense
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
