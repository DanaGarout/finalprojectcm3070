import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/custom_widgets/sign_in_custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ultratasks/core/utils/constants.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _renewPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  void _changePassword() async {
    if (_newPasswordController.text != _renewPasswordController.text) {
      setState(() {
        _errorMessage =
            AuthConstants.passwordNotmatch; // Error: passwords do not match
      });
      return;
    }

    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Reauthenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _currentPasswordController.text,
        );
        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(_newPasswordController.text);
        setState(() {
          _errorMessage = ProfileConstants.passwordSuccess; // Success message
        });

        // Sign out the user and navigate back to the login screen
        await _auth.signOut();
        // ignore: use_build_context_synchronously
        Navigator.of(context).popUntil((route) => route.isFirst);
      } catch (e) {
        setState(() {
          _errorMessage =
              "Failed to update password: ${e.toString()}"; // Error handling
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: true,
      pageTitle: ProfileConstants.changePassword,
      backgroundColor: AppColor.white,
      appBarColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              SettingsAssetsPath.changePassword,
            ),
            AppDimensions.sizedBoxH10,
            SignInCustomTextField(
              labelText: ProfileConstants.currentPassword,
              hintText: ProfileConstants.enterCurrent,
              controller: _currentPasswordController,
              obscureText: true,
            ),
            SignInCustomTextField(
              labelText: ProfileConstants.createNew,
              hintText: ProfileConstants.enterNew,
              controller: _newPasswordController,
              obscureText: true,
            ),
            SignInCustomTextField(
              labelText: ProfileConstants.reCreateNew,
              hintText: ProfileConstants.enterReCreate,
              controller: _renewPasswordController,
              obscureText: true,
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const Expanded(
              child: SizedBox(),
            ),
            ButtonCustomWidget(
              text: ProfileConstants.savePassword,
              buttonColor: AppColor.pink,
              onPressed: _changePassword, // Trigger password change
            ),
            AppDimensions.sizedBoxH16,
          ],
        ),
      ),
    );
  }
}
