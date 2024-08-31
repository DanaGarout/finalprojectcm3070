import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';
import 'package:ultratasks/core/utils/constants.dart';

class SignInIntroduction extends StatelessWidget {
  const SignInIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 254,
      child: Text(
        // Displays a predefined introduction message for the sign-in page
        AuthConstants.signInIntroduction,
        textAlign: TextAlign.center,
        style: SignInStyles.authParagraphTextStyle,
      ),
    );
  }
}
