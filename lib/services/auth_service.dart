import 'package:firebase_auth/firebase_auth.dart';  

class AuthService {  
  final FirebaseAuth _auth = FirebaseAuth.instance;  

  Future<UserCredential?> register(String email, String password) async {  
    try {  
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(  
        email: email,  
        password: password,  
      );  
      return userCredential;  
    } on FirebaseAuthException catch (e) {  
      print(e.message);  
      return null;  
    }  
  }  

  Future<UserCredential?> login(String email, String password) async {  
    try {  
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(  
        email: email,  
        password: password,  
      );  
      return userCredential;  
    } on FirebaseAuthException catch (e) {  
      print(e.message);  
      return null;  
    }  
  }  

  Future<void> logout() async {  
    await _auth.signOut();  
  }  

  Stream<User?> getCurrentUser() {  
    return _auth.authStateChanges();  
  }  
}