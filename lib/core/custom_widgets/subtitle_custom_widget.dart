import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';

class SectionTitleWidget extends StatelessWidget {
  final String subtitle;

  const SectionTitleWidget({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: HomeStyles.sectionTitleWidgetStyle, // Apply custom text style
    );
  }
}
