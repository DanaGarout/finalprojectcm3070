import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Auth/SignIn/pages/sign_in_page.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_up_if_account.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_in_introduction.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_in_logo_title.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/or_sign_in_widget.dart';
import 'package:ultratasks/features/Auth/SignUp/sign_up_page.dart';

class SignInIntroPage extends StatelessWidget {
  const SignInIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.beige,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the default back button
        toolbarHeight: 50, // Set custom height for the AppBar
        backgroundColor: AppColor.beige,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SignInLogoTitle(), // Displays the app logo and title
            const SizedBox(
              height: 19,
            ),
            const SignInIntroduction(), // Introduction text or message
            const SizedBox(
              height: 129,
            ),
            ButtonCustomWidget(
              text: AuthConstants.signIn,
              buttonColor: AppColor.pink,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const SignInPage(), // Navigate to the sign-in page
                  ),
                );
              },
            ),
            const SizedBox(
              height: 5,
            ),
            const OrSignInWidget(), // "Or sign in with" divider or message
            const SizedBox(
              height: 5,
            ),
            ButtonCustomWidget(
              text: AuthConstants.signUp,
              buttonColor: AppColor.pink,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        const SignUpPage(), // Navigate to the sign-up page
                  ),
                );
              },
            ),
            const Expanded(
              child:
                  SizedBox(), // Spacer to push the SignUpIfNoAccount widget to the bottom
            ),
            SignUpIfNoAccount(
              firstLine: AuthConstants.noAccountLine,
              secondLine: AuthConstants.signUp,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          const SignUpPage()), // Navigate to sign-up page
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
