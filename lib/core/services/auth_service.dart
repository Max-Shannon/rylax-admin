import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../styles/app_colors.dart';
import '../utils/snack_barz.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signIn({required String email, required String password, required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      //DEBUG: Remove
      var token = await getFirebaseToken();
      print(token);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> getFirebaseToken() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Force refresh if you need the latest token
      return await user.getIdToken(true);
    }
    return null;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  User? getLoggedInUser() {
    return _auth.currentUser;
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    //TODO:
    //NavigationService().navigateToLoginView(context);
  }

  void _showLoginFailedSnackBar(BuildContext context) {
    SnackBarz.showSnackBar(context, AppColors.mainRed, "Login Failed - Check credentials!");
  }
}
