// import 'dart:developer' as developer;
// import 'package:flutter/foundation.dart';
// import '../models/user.dart';
// import '../services/auth_service.dart';

// class AuthProvider with ChangeNotifier {
//   final _authService = AuthService();
//   User? _currentUser;
//   bool _isLoading = false;

//   AuthProvider() {
//     loadSavedSession();
//   }

//   User? get currentUser => _currentUser;
//   bool get isLoading => _isLoading;
//   bool get isAuthenticated => _currentUser != null;

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   Future<void> login(String email, String password) async {
//     _setLoading(true);
//     try {
//       _currentUser = await _authService.login(email, password);
//       notifyListeners();
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> register(String name, String email, String password, String passwordConfirmation) async {
//     _setLoading(true);
//     try {
//       _currentUser = await _authService.register(name, email, password, passwordConfirmation);
//       notifyListeners();
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> logout() async {
//     _setLoading(true);
//     try {
//       await _authService.logout();
//       _currentUser = null;
//       notifyListeners();
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> loadSavedSession() async {
//     _setLoading(true);
//     try {
//       _currentUser = await _authService.loadSavedUser();
//       if (_currentUser != null) {
//         developer.log('Loaded saved user: ${_currentUser!.email}');
//       } else {
//         developer.log('No saved user session found');
//       }
//       notifyListeners();
//     } catch (e) {
//       developer.log('Error loading saved session: $e');
//     } finally {
//       _setLoading(false);
//     }
//   }
// }
