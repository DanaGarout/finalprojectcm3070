import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class SignInCustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? textInputType;
  final String? errorText;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted; // Add this parameter

  const SignInCustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.textInputType,
    this.onTap,
    this.obscureText = false,
    this.errorText,
    this.onFieldSubmitted, // Accept the callback
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText, style: SignInStyles.authTextFieldLabelStyle),
          const SizedBox(height: 8),
          TextField(
            onTap: onTap,
            keyboardType: textInputType,
            controller: controller,
            obscureText: obscureText,
            onSubmitted: onFieldSubmitted, // Pass the callback here

            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.primaryGrey,
                ),
              ),
              filled: true,
              fillColor: AppColor.white,
              errorText: errorText,
            ),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                errorText!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
