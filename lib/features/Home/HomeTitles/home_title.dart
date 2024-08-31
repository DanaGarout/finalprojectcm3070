import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Container(
          width: 44,
          height: 44,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF795548),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(77),
            ),
            shadows: const [
              HomeStyles.homeTitleBoxShadowStyle,
            ],
          ),
          child: SvgPicture.asset(
            HomeAssetsPath.appLogo, // Display the app's logo
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          HomeConstants.appName,
          style: HomeStyles.ultraTaskTitleTextStyle, // Display the app's name
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
