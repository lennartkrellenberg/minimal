import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal/src/business_logic/services/database_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateCanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String name, String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userId = (FirebaseAuth.instance.currentUser.uid);
      addUser(name, email, userId);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "logged out";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> getUserInfo(userName) async {
    var userUid;
    var userEmail;
    userUid = (FirebaseAuth.instance.currentUser.uid);
    userEmail = _firebaseAuth.currentUser.email;

    try {
      addUser(userName, userEmail, userUid);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
