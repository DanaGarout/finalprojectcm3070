import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';

class OrSignInWidget extends StatelessWidget {
  const OrSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 246,
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppDimensions.sizedBoxH8,
          // Displays a localized 'or' text with a specific style
          Text(
            AuthConstants.or,
            style: SignInStyles.authOrTextStyle,
          ),
          AppDimensions.sizedBoxW12,
        ],
      ),
    );
  }
}
