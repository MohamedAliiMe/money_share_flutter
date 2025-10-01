import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/groups_provider.dart';
import '../services/expense_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _expenseService = ExpenseService();
  bool _isEditing = false;
  int _totalExpenses = 0;

  Future<void> _loadTotalExpenses() async {
    try {
      final count = await _expenseService.getTotalExpenses();
      if (mounted) {
        setState(() {
          _totalExpenses = count;
        });
      }
    } catch (e) {
      log('Failed to load total expenses: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load total expenses: $e')),
        );
      }
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final user = Provider.of<AuthProvider>(context, listen: false).currentUser!;
  //   _nameController = TextEditingController(text: user.name);
  //   _emailController = TextEditingController(text: user.email);
  //   _loadTotalExpenses();
  // }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _emailController.dispose();
  //   super.dispose();
  // }

  // void _toggleEdit() {
  //   setState(() {
  //     _isEditing = !_isEditing;
  //     if (!_isEditing) {
  //       // Reset controllers to original values
  //       final user =
  //           Provider.of<AuthProvider>(context, listen: false).currentUser!;
  //       _nameController.text = user.name;
  //       _emailController.text = user.email;
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Screen - Under Construction'),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Profile'),
    //     actions: [
    //       IconButton(
    //         icon: Icon(_isEditing ? Icons.close : Icons.edit),
    //         onPressed: _toggleEdit,
    //       ),
    //       if (_isEditing)
    //         IconButton(
    //           icon: const Icon(Icons.check),
    //           onPressed: _saveChanges,
    //         ),
    //     ],
    //   ),
    //   body: Consumer<AuthProvider>(
    //     builder: (context, auth, _) {
    //       final user = auth.currentUser!;
    //       return SingleChildScrollView(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Form(
    //           key: _formKey,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Center(
    //                 child: CircleAvatar(
    //                   radius: 50,
    //                   backgroundColor: Theme.of(context).primaryColor,
    //                   child: Text(
    //                     user.name[0].toUpperCase(),
    //                     style: const TextStyle(
    //                       fontSize: 36,
    //                       color: Colors.white,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(height: 32),
    //               TextFormField(
    //                 controller: _nameController,
    //                 decoration: const InputDecoration(
    //                   labelText: 'Name',
    //                   border: OutlineInputBorder(),
    //                 ),
    //                 enabled: _isEditing,
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'Please enter your name';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               const SizedBox(height: 16),
    //               TextFormField(
    //                 controller: _emailController,
    //                 decoration: const InputDecoration(
    //                   labelText: 'Email',
    //                   border: OutlineInputBorder(),
    //                 ),
    //                 enabled: _isEditing,
    //                 keyboardType: TextInputType.emailAddress,
    //                 validator: (value) {
    //                   if (value == null || value.isEmpty) {
    //                     return 'Please enter your email';
    //                   }
    //                   if (!value.contains('@')) {
    //                     return 'Please enter a valid email';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               const SizedBox(height: 32),
    //               if (!_isEditing) ...[
    //                 const Text(
    //                   'Account Statistics',
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 16),
    //                 ListTile(
    //                   leading: const Icon(Icons.group),
    //                   title: const Text('Total Groups'),
    //                   trailing: Consumer<GroupsProvider>(
    //                     builder: (context, groupsProvider, child) {
    //                       return Text(
    //                         '${groupsProvider.groups.length}',
    //                         style: const TextStyle(fontSize: 18),
    //                       );
    //                     },
    //                   ),
    //                 ),
    //                 const Divider(),
    //                 ListTile(
    //                   leading: const Icon(Icons.receipt_long),
    //                   title: const Text('Total Expenses'),
    //                   trailing: Text(
    //                     '$_totalExpenses',
    //                     style: const TextStyle(fontSize: 18),
    //                   ),
    //                 ),
    //               ],
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
