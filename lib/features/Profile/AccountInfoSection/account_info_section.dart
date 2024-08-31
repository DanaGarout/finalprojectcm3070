import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Profile/AccountInfoSection/profile_birth_widget.dart';
import 'package:ultratasks/features/Profile/AccountInfoSection/profile_email_widget.dart';
import 'package:ultratasks/features/Profile/AccountInfoSection/profile_phone_widget.dart';
import 'package:ultratasks/features/Profile/profile_section_title.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileSectionTitle(
          sectionTitle:
              ProfileConstants.accountInfo, // Account Info section title
        ),
        AppDimensions.sizedBoxH6,
        ProfileEmailWidget(), // Display user email
        ProfileBirthWidget(), // Display user birth date
        ProfilePhoneWidget(), // Display user phone number
      ],
    );
  }
}
