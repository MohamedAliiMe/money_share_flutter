import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import '../domain/model/groups/group.dart';
import '../domain/model/groups/user.dart';
import '../../../services/expense_service.dart';

class CreateExpenseScreen extends StatefulWidget {
  final GroupModel group;

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
  late UserModel _selectedPayer;
  Map<UserModel, double> _splits = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();

    if (widget.group.members == null || widget.group.members!.isEmpty) {
      throw Exception(LocaleKeys.groupHasNoMembers.tr());
    }

    _selectedPayer = widget.group.members!.first;
    _initializeSplits();
  }

  void _initializeSplits() {
    _splits = {
      for (var member in widget.group.members ?? [])
        member: 1.0 / (widget.group.members?.length ?? 1),
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
    final splits = _splits.entries
        .map((entry) => {
              'user_id': entry.key.id,
              'amount': amount * entry.value,
            })
        .toList();

    try {
      await _expenseService.createExpense(
        groupId: widget.group.id ?? 0,
        paidById: _selectedPayer.id ?? 0,
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
          SnackBar(
            content: Text('${LocaleKeys.createExpenseFailed.tr()} $e'),
          ),
        );
      }
    }
  }

  void _showSplitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocaleKeys.splitExpense.tr()),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (var member in widget.group.members ?? [])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(member.name)),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          initialValue:
                              (_splits[member]! * 100).toStringAsFixed(0),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            suffix: const Text('%'),
                            border: const OutlineInputBorder(),
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
            child: Text(LocaleKeys.done.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.addExpense.tr()),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: LocaleKeys.description.tr(),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.descriptionValidation.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: LocaleKeys.amount.tr(),
                prefixText: '\$ ',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.amountValidation.tr();
                }
                if (double.tryParse(value) == null) {
                  return LocaleKeys.amountInvalid.tr();
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ListTile(
              title: Text(LocaleKeys.paidBy.tr()),
              trailing: DropdownButton<UserModel>(
                value: _selectedPayer,
                items: (widget.group.members ?? [])
                    .map((member) => DropdownMenuItem(
                          value: member,
                          child: Text(member.name ?? ''),
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
              title: Text(LocaleKeys.date.tr()),
              trailing: TextButton(
                onPressed: _selectDate,
                child: Text(_selectedDate.toString().split(' ')[0]),
              ),
            ),
            ListTile(
              title: Text(LocaleKeys.split.tr()),
              trailing: TextButton(
                onPressed: _showSplitDialog,
                child: Text(LocaleKeys.editSplit.tr()),
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
          child: Text(LocaleKeys.createExpense.tr()),
        ),
      ),
    );
  }
}
