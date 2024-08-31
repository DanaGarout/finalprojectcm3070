import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/features/Auth/SignIn/pages/sign_in_page.dart';
import 'package:ultratasks/features/SplashPage/splash_logo_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ultratasks/features/ultra_task.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter bindings are initialized before any other operation

  // Initialize Firebase based on the platform (Android or others)
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAtNfgV-GTvhvJfIYVSXa33CZxQCKU3ml8",
              authDomain: "ultratask-project.firebaseapp.com",
              projectId: "ultratask-project",
              storageBucket: "ultratask-project.appspot.com",
              messagingSenderId: "421309074237",
              appId: "1:421309074237:web:cc517513fb55464a8a1354",
              measurementId: "G-1KNNCBE15L"))
      : await Firebase.initializeApp();

  runApp(const MyApp()); // Run the main app widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'UltraTasks',
      debugShowCheckedModeBanner: false, // Disable the debug banner
      home: AuthWrapper(), // Start with the AuthWrapper widget
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Listen for authentication state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashLogoPage(); // Show splash screen while waiting for authentication state
        } else if (snapshot.hasData) {
          DatabaseService()
              .initializeUserTasks(); // Initialize user tasks if authenticated
          return const UltraTask(); // Navigate to the main app if authenticated
        } else {
          return const SignInPage(); // Navigate to the sign-in page if not authenticated
        }
      },
    );
  }
}
