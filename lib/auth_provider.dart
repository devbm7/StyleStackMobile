import 'package:flutter/foundation.dart';  
import 'package:firebase_auth/firebase_auth.dart';  
import '../services/auth_service.dart';  

class AuthProvider with ChangeNotifier {  
  final AuthService _authService = AuthService();  
  User? _user;  

  User? get user => _user;  

  AuthProvider() {  
    _authService.getCurrentUser().listen((User? user) {  
      _user = user;  
      notifyListeners();  
    });  
  }  

  Future<bool> login(String email, String password) async {  
    try {  
      final userCredential = await _authService.login(email, password);  
      return userCredential != null;  
    } catch (e) {  
      print(e);  
      return false;  
    }  
  }  

  Future<bool> register(String email, String password) async {  
    try {  
      final userCredential = await _authService.register(email, password);  
      return userCredential != null;  
    } catch (e) {  
      print(e);  
      return false;  
    }  
  }  

  Future<void> logout() async {  
    await _authService.logout();  
  }  
}