import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/custom_widgets/sign_in_custom_textfield.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_up_if_account.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_in_logo_title.dart';
import 'package:ultratasks/features/Auth/SignUp/sign_up_page.dart';
import 'package:ultratasks/core/firebase/services/firebase_auth_services.dart';
import 'package:ultratasks/features/ultra_task.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuthServices auth =
      FirebaseAuthServices(); // Service for handling Firebase Auth

  final TextEditingController emailController =
      TextEditingController(); // Controller for email input
  final TextEditingController passwordController =
      TextEditingController(); // Controller for password input

  String? emailError; // Holds the email error message if validation fails
  String? passwordError; // Holds the password error message if validation fails

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    // Validate email and password inputs
    setState(() {
      emailError =
          emailController.text.isEmpty ? AuthConstants.emailError : null;
      passwordError =
          passwordController.text.isEmpty ? AuthConstants.passwordError : null;
    });
  }

  void _signIn() async {
    _validateInputs(); // Check if inputs are valid

    if (emailError == null && passwordError == null) {
      // Only proceed if there are no validation errors
      String email = emailController.text;
      String password = passwordController.text;

      User? user = await auth.signInWithEmailAndPassword(
          email, password); // Attempt sign-in

      if (user != null) {
        DatabaseService()
            .initializeUserTasks(); // Initialize user-specific data in Firestore

        if (kDebugMode) {
          print(AuthConstants.signInSuccess);
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const UltraTask()), // Navigate to the main app page
        );
      } else {
        if (kDebugMode) {
          print(AuthConstants.signInFail);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      pageTitle: '',
      backgroundColor: AppColor.beige,
      appBarColor: AppColor.beige,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SignInLogoTitle(), // Displays the app logo and title
            SignInCustomTextField(
              textInputType: TextInputType.emailAddress,
              labelText: AuthConstants.email,
              hintText: AuthConstants.emailExample,
              controller: emailController,
              errorText: emailError, // Display email error if any
              onFieldSubmitted: (_) => FocusScope.of(context)
                  .nextFocus(), // Move to the next input field
            ),
            SignInCustomTextField(
              textInputType: TextInputType.visiblePassword,
              labelText: AuthConstants.password,
              hintText: '',
              errorText: passwordError, // Display password error if any
              controller: passwordController,
              onFieldSubmitted: (_) =>
                  _signIn(), // Trigger sign-in when the user submits the password
            ),
            ButtonCustomWidget(
              text: AuthConstants.login,
              buttonColor: AppColor.pink,
              onPressed: _signIn, // Trigger sign-in when the button is pressed
            ),
            const SizedBox(
              height: 26,
            ),
            SignUpIfNoAccount(
              firstLine: AuthConstants.noAccountLine,
              secondLine: AuthConstants.signUp,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const SignUpPage())); // Navigate to the sign-up page
              },
            ),
          ],
        ),
      ),
    );
  }
}
