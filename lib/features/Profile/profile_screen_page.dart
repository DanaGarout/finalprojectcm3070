import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Auth/SignIn/pages/sign_in_page.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/features/Profile/AccountInfoSection/account_info_section.dart';
import 'package:ultratasks/features/Profile/AccountSettingsSection/account_settings_section.dart';
import 'package:ultratasks/features/Profile/break_line_widget.dart';
import 'package:ultratasks/features/Profile/PictureNameSection/username_image_widget.dart';
import 'package:ultratasks/features/Profile/TasksProgressSection/tasks_progress_section.dart';

class ProfileScreenPage extends StatelessWidget {
  const ProfileScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      pageTitle: ProfileConstants.profile,
      backgroundColor: AppColor.peach,
      appBarColor: AppColor.peach,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const UsernameImageWidget(), // Display user's image and name
                const TasksProgressSection(), // Display user's task progress
                const AccountInfoSection(), // Display user's account information
                const BreakLineWidget(), // Add a visual separator
                const AccountSettingsSection(), // Display account settings
                AppDimensions.sizedBoxH16,
                ButtonCustomWidget(
                  text: ProfileConstants.logOut, // Log out button text
                  buttonColor: AppColor.brown, // Set button color
                  onPressed: () {
                    FirebaseAuth.instance.signOut(); // Sign out the user
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const SignInPage()), // Navigate to sign-in page
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
