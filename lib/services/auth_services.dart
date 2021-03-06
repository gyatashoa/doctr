import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  late final FirebaseAuth _instance;
  AuthServices() {
    _instance = FirebaseAuth.instance;
  }

  User? get currentUser => _instance.currentUser;

  Future login({required String email, required String password}) async {
    try {
      UserCredential result = await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on Exception {
      return 'Error while logging in';
    }
  }

  Future forgotPassword({required String email}) async {
    try {
      await _instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on Exception {
      return 'Error while logging in';
    }
  }

  Future signUp(
      {required String email,
      required String name,
      required String password}) async {
    try {
      UserCredential result = await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user!.updateDisplayName(name);
      await result.user!.reload();
      return result;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } on Exception {
      return 'Error while creating user';
    }
  }

  Future<void> signOut() async => await _instance.signOut();
}
