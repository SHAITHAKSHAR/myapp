import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  AuthProvider() {
    _user = _authService.getCurrentUser();
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<void> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      // Re-throw the exception to be handled by the UI
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> updateProfile(String displayName) async {
    try {
      await _authService.updateProfile(displayName);
      _user = _authService.getCurrentUser(); // Refresh the user
      notifyListeners();
    } catch (e) {
      // Re-throw the exception to be handled by the UI
      rethrow;
    }
  }

  Future<void> uploadProfilePicture(File image) async {
    try {
      await _authService.uploadProfilePicture(image);
      _user = _authService.getCurrentUser(); // Refresh the user
      notifyListeners();
    } catch (e) {
      // Re-throw the exception to be handled by the UI
      rethrow;
    }
  }
}
