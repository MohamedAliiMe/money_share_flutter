import 'package:flutter/material.dart';
import 'package:splitwise_flutter/features/authentication/data/models/user_model/usermodel.dart';
import 'package:splitwise_flutter/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../services/user_service.dart';

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final _searchController = TextEditingController();
  final _userService = UserService();
  List<UserModel> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _userService.searchUsers(query);
      setState(() {
        _searchResults = results
            .map((user) => UserModel(
                  id: user.id,
                  name: user.name,
                  email: user.email,
                ))
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${LocaleKeys.searchFailed.tr()} ${e.toString()}',
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: LocaleKeys.searchUsers.tr(),
                hintText: LocaleKeys.enterEmailOrName.tr(),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) => _searchUsers(value),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final user = _searchResults[index];
                    return ListTile(
                      title: Text(user.name ?? ''),
                      subtitle: Text(user.email ?? ''),
                      onTap: () => Navigator.of(context).pop(user),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
