import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/AuthStyles/sign_in_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class ButtonCustomWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;

  const ButtonCustomWidget({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: AppColor.boxShadow,
              blurRadius: 4,
              offset: Offset(2, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: SignInStyles.authButtonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
