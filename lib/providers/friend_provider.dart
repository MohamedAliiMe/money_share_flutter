import 'package:flutter/foundation.dart';
import '../models/friend.dart';
import '../services/friend_service.dart';

class FriendProvider with ChangeNotifier {
  final FriendService _friendService;
  List<Friend> _friends = [];
  bool _isLoading = false;
  String? _error;

  FriendProvider(this._friendService);

  List<Friend> get friends => _friends;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFriends() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _friends = await _friendService.getFriends();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendFriendRequest(int friendId) async {
    try {
      await _friendService.sendFriendRequest(friendId);
      await loadFriends();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> acceptFriendRequest(int friendshipId) async {
    try {
      await _friendService.acceptFriendRequest(friendshipId);
      await loadFriends();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<List<Friend>> searchUsers(String query) async {
    try {
      return await _friendService.searchUsers(query);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  Future<String> generateQrCode() async {
    try {
      return await _friendService.generateQrCode();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
