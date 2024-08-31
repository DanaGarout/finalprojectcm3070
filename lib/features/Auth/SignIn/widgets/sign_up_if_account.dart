import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';

class SignUpIfNoAccount extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final VoidCallback onPressed;

  const SignUpIfNoAccount(
      {super.key,
      required this.firstLine,
      required this.secondLine,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Text.rich(
            TextSpan(
              children: [
                // Displays the first part of the message
                TextSpan(
                  text: firstLine,
                  style: SignInStyles.authEndFirstLineStyle,
                ),
                const TextSpan(
                  text: ' ',
                  style: SignInStyles.authEndMidStyle,
                ),
                // Displays the second part of the message (actionable)
                TextSpan(
                  text: secondLine,
                  style: SignInStyles.authEndSecondLineStyle,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
