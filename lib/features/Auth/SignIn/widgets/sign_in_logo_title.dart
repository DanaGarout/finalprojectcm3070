import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';

class SignInLogoTitle extends StatelessWidget {
  const SignInLogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF795548),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(77),
            ),
            shadows: const [
              SignInStyles.signInIntroBoxShadow,
            ],
          ),
          // Displays the application logo using an SVG asset
          child: Center(
            child: SvgPicture.asset(
              HomeAssetsPath.appLogo,
            ),
          ),
        ),

        AppDimensions.sizedBoxH8,
        // Displays the application name below the logo
        const Text(
          AuthConstants.appName,
          style: SignInStyles.authLogoTextStyle,
        )
      ],
    );
  }
}
