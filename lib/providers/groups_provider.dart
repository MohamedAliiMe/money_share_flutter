import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import '../models/group.dart';
import '../services/group_service.dart';

class GroupsProvider with ChangeNotifier {
  final _groupService = GroupService();
  List<Group> _groups = [];
  bool _isLoading = false;
  String? _error;

  List<Group> get groups => _groups;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    _error = null;
    notifyListeners();
  }

  Future<void> loadGroups() async {
    developer.log('Loading groups...');
    _setLoading(true);
    try {
      _groups = await _groupService.getGroups();
      developer.log('Groups loaded successfully: ${_groups.length} groups');
      _error = null;
      notifyListeners();
    } catch (e) {
      developer.log('Error loading groups: $e');
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createGroup(String name, List<int> memberIds) async {
    _setLoading(true);
    try {
      final group = await _groupService.createGroup(name, memberIds);
      _groups.add(group);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addMemberToGroup(int groupId, int userId) async {
    _setLoading(true);
    try {
      await _groupService.addMemberToGroup(groupId, userId);
      await loadGroups(); // Reload groups to get updated data
      _error = null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeMemberFromGroup(int groupId, int userId) async {
    _setLoading(true);
    try {
      await _groupService.removeMemberFromGroup(groupId, userId);
      await loadGroups(); // Reload groups to get updated data
      _error = null;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }
}
