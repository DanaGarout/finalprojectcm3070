import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Auth/SignIn/pages/sign_in_intro_page.dart';

class SplashLogoPage extends StatefulWidget {
  const SplashLogoPage({super.key});

  @override
  State<SplashLogoPage> createState() => _SplashLogoPageState();
}

class _SplashLogoPageState extends State<SplashLogoPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                const SignInIntroPage(), // Navigate to Sign-In Intro Page
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.brown, // Set background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                HomeAssetsPath.appLogo, // Display app logo
                width: 149,
                height: 130,
              ),
              const Text(
                HomeConstants.appName,
                style: SignInStyles.splashLogoTitleStyle, // Display app name
              ),
            ],
          ),
        ),
      ),
    );
  }
}
