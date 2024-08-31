import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class SignInStyles {
  // Splash Page
  static const splashLogoTitleStyle = TextStyle(
    color: AppColor.white,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.0,
  );
  // Sign in Intro Page
  static const authLogoTextStyle = TextStyle(
    color: AppColor.black,
    fontSize: 24,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static const signInIntroBoxShadow = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 4,
    offset: Offset(2, 2),
    spreadRadius: 0,
  );
  static const authParagraphTextStyle = TextStyle(
    color: AppColor.black,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static const authButtonTextStyle = TextStyle(
    color: AppColor.white,
    fontSize: 16,
    fontFamily: 'Jost',
    fontWeight: FontWeight.bold,
  );
  static const authOrTextStyle = TextStyle(
    color: AppColor.brown,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w600,
    height: 0,
  );
  static const authEndFirstLineStyle = TextStyle(
    color: AppColor.black,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static const authEndMidStyle = TextStyle(
    color: AppColor.black,
    fontSize: 15,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static const authEndSecondLineStyle = TextStyle(
    color: AppColor.primaryBlue,
    fontSize: 16,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static const authTextFieldLabelStyle = TextStyle(
    color: Color(0xFF795548),
    fontSize: 16,
    fontFamily: 'Josefin Sans',
    fontWeight: FontWeight.w600,
    height: 0,
  );
}
