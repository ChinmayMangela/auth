

import 'package:auth/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> logInWithEmail(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    return null;
  }

  Future<UserCredential?> createUserWithEmail(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    return null;
  }

  Future<void> sendEmailVerification() async {
    Utils.showSnackBar('Email has been sent');
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future<void> sendVerificationEmail() async {
    try{
      final user = _auth.currentUser;
      await user!.sendEmailVerification();
    } catch(e) {
      Utils.showSnackBar(e.toString());
    }
  }
}