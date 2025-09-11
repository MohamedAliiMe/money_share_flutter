import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/group_service.dart';
import '../widgets/add_member_dialog.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _groupService = GroupService();
  List<User> _selectedMembers = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleCreateGroup() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedMembers.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please add at least one member')),
        );
        return;
      }

      try {
        final memberIds = _selectedMembers.map((user) => user.id).toList();
        await _groupService.createGroup(_nameController.text, memberIds);
        if (mounted) {
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create group: ${e.toString()}')),
          );
        }
      }
    }
  }

  Future<void> _showAddMemberDialog() async {
    final result = await showDialog<User>(
      context: context,
      builder: (context) => const AddMemberDialog(),
    );

    if (result != null && mounted) {
      setState(() {
        if (!_selectedMembers.contains(result)) {
          _selectedMembers.add(result);
        }
      });
    }
  }

  void _removeMember(User user) {
    setState(() {
      _selectedMembers.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a group name';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Members',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: _showAddMemberDialog,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Member'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedMembers.length,
              itemBuilder: (context, index) {
                final member = _selectedMembers[index];
                return ListTile(
                  title: Text(member.name),
                  subtitle: Text(member.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => _removeMember(member),
                    color: Colors.red,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _handleCreateGroup,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Create Group'),
        ),
      ),
    );
  }
}
