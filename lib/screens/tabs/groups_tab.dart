import 'package:flutter/material.dart';
import '../../models/group.dart';
import '../group_details_screen.dart';
import '../create_group_screen.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({super.key});

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  List<Group> groups = [];

  @override
  void initState() {
    super.initState();
    _loadGroups();
  }

  Future<void> _loadGroups() async {
    setState(() {
      groups = [
        Group(
          id: 1,
          name: 'Family',
          description: 'Family expenses',
          totalSpent: 120.50,
          members: [], // Add mock members here if needed
        ),
        Group(
          id: 2,
          name: 'Friends',
          description: 'Trip expenses',
          totalSpent: 300.00,
          members: [], // Add mock members here if needed
        ),
      ];
    });
  }

  Future<void> _refreshGroups() async {
    await _loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshGroups,
        child: Scaffold(
          body: groups.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No groups yet. Create one to get started!'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateGroupScreen(),
                            ),
                          );
                        },
                        child: const Text('Create Group'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final Group group = groups[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.group),
                      ),
                      title: Text(group.name),
                      subtitle: Text(group.description ?? ''),
                      trailing: Text(
                        group.totalSpent > 0
                            ? '\$${group.totalSpent.toStringAsFixed(2)}'
                            : '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GroupDetailsScreen(group: group),
                          ),
                        );
                      },
                    );
                  },
                ),
        ));
  }
}