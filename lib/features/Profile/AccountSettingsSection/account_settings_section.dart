import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ultratasks/core/styles/AppStyles/SettingsStyles/settings_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Profile/AccountSettingsSection/change_password_page.dart';
import 'package:ultratasks/features/Profile/profile_section_title.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionTitle(
          sectionTitle: ProfileConstants
              .accountSettings, // Account Settings section title
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      const ChangePasswordPage()), // Navigate to change password page
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: ShapeDecoration(
              color: AppColor.blackShadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      SettingsAssetsPath.changePasswordIcon,
                    ),
                    AppDimensions.sizedBoxW20,
                  ],
                ),
                const Text(
                  ProfileConstants.changePassword,
                  style: SettingsStyles.accountSettingsSectionTitleStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
