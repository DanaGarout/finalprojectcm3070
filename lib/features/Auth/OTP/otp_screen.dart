import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/otp_verification_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Auth/SignIn/pages/sign_in_page.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/custom_widgets/sign_in_custom_textfield.dart';

class OtpScreen extends StatefulWidget {
  final String
      verificationId; // The verification ID required for OTP verification

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController =
      TextEditingController(); // Controller for OTP input

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: true,
      appBarColor: AppColor.peach,
      backgroundColor: AppColor.peach,
      pageTitle: '',
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                SettingsAssetsPath
                    .lock, // Display a lock icon to represent security
              ),
              AppDimensions.sizedBoxH10,
              const Text(
                AuthConstants.otpVerification,
                style: OtpVerificationStyles.otpTitleStyle,
              ),
              const Text(
                AuthConstants.otpText,
                textAlign: TextAlign.center,
                style: OtpVerificationStyles.otpMessageStyle,
              ),
              SignInCustomTextField(
                labelText: '',
                hintText: AuthConstants.enterCode,
                controller: otpController, // Bind OTP input to the controller
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ButtonCustomWidget(
                text: AuthConstants.verify,
                buttonColor: AppColor.primaryBlue,
                onPressed: () async {
                  try {
                    final cred = PhoneAuthProvider.credential(
                      verificationId: widget
                          .verificationId, // Use the provided verification ID
                      smsCode:
                          otpController.text, // Use the OTP entered by the user
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(cred); // Sign in using the OTP
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignInPage(), // Navigate to sign-in page upon success
                      ),
                    );
                  } catch (e) {
                    if (kDebugMode) {
                      print(
                          'Error has occurred: $e'); // Log error in debug mode
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
