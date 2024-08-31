import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/SettingsStyles/settings_styles.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String sectionTitle;
  const ProfileSectionTitle({
    super.key,
    required this.sectionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      sectionTitle,
      style: SettingsStyles.settingsTitleTextStyle,
    );
  }
}
