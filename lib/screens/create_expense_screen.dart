import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/group.dart';
import '../models/user.dart';
import '../services/expense_service.dart';

class CreateExpenseScreen extends StatefulWidget {
  final Group group;

  const CreateExpenseScreen({
    super.key,
    required this.group,
  });

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _expenseService = ExpenseService();
  late DateTime _selectedDate;
  late User _selectedPayer;
  Map<User, double> _splits = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    
    if (widget.group.members.isEmpty) {
      throw Exception('Group has no members');
    }

    // Initialize with the first member as payer
    _selectedPayer = widget.group.members.first;
    _initializeSplits();
  }

  void _initializeSplits() {
    _splits = {
      for (var member in widget.group.members)
        member: 1.0 / widget.group.members.length, // Equal split by default
    };
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.parse(_amountController.text);
    final splits = _splits.entries.map((entry) => {
      'user_id': entry.key.id,
      'amount': amount * entry.value, // Calculate actual amount for each split
    }).toList();

    try {
      await _expenseService.createExpense(
        groupId: widget.group.id,
        paidById: _selectedPayer.id,
        description: _descriptionController.text,
        amount: amount,
        date: _selectedDate,
        splits: splits,
      );

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create expense: $e')),
        );
      }
    }
  }

  void _showSplitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Split Expense'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (var member in widget.group.members)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(member.name)),
                        SizedBox(
                        width: 100,
                        child: TextFormField(
                          initialValue: (_splits[member]! * 100).toStringAsFixed(0),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            suffix: Text('%'),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            final percentage = int.tryParse(value) ?? 0;
                            setState(() {
                              _splits[member] = percentage / 100;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Paid by'),
              trailing: DropdownButton<User>(
                value: _selectedPayer,
                items: widget.group.members.map((member) => DropdownMenuItem(
                          value: member,
                          child: Text(member.name),
                        ))
                    .toList(),
                onChanged: (user) {
                  if (user != null) {
                    setState(() => _selectedPayer = user);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Date'),
              trailing: TextButton(
                onPressed: _selectDate,
                child: Text(
                  _selectedDate.toString().split(' ')[0],
                ),
              ),
            ),
            ListTile(
              title: const Text('Split'),
              trailing: TextButton(
                onPressed: _showSplitDialog,
                child: const Text('Edit Split'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _handleSubmit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Create Expense'),
        ),
      ),
    );
  }
}
