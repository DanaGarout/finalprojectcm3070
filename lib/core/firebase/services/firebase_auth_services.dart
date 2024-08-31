import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthServices {
  // FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign up a user with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to create a user with the provided email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Return the created user
      return credential.user;
    } catch (e) {
      // Print error message in debug mode if an error occurs
      if (kDebugMode) {
        print('Some error occurred during sign-up');
      }
    }
    // Return null if sign-up fails
    return null;
  }

  // Method to sign in a user with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Attempt to sign in with the provided email and password
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Return the signed-in user
      return credential.user;
    } catch (e) {
      // Print error message in debug mode if an error occurs
      if (kDebugMode) {
        print('Some error occurred during sign-in');
      }
    }
    // Return null if sign-in fails
    return null;
  }
}
