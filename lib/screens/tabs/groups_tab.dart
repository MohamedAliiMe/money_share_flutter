import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/groups_provider.dart';
import '../../models/group.dart';
import '../group_details_screen.dart';
import '../create_group_screen.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({super.key});

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupsProvider>().loadGroups();
    });
  }

  Future<void> _refreshGroups() async {
    await context.read<GroupsProvider>().loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshGroups,
      child: Consumer<GroupsProvider>(
        builder: (context, groupsProvider, child) {
          if (groupsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (groupsProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${groupsProvider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshGroups,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final groups = groupsProvider.groups;
          if (groups.isEmpty) {
            return Center(
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
            );
          }

        return ListView.builder(
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
                    builder: (context) => GroupDetailsScreen(group: group),
                  ),
                );
              },
            );
          },
        );
      },
    ),
  );
  }
}
