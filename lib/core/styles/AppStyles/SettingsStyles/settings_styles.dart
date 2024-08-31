import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class SettingsStyles {
  // Settings Screen Pages Style
  static const themeSettingsTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static const accountSettingsSectionTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0.05,
  );
  static const termsAndPolicyTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0.05,
  );
  static const changeLanguageTitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static const changeLanguageTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w400,
    height: 0,
  );static const settingsTitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w800,
    height: 0,
  );
  static const settingsInputTextFieldLabelStyle = TextStyle(
    color: Color(0xFF795548),
    fontSize: 16,
    fontFamily: 'Josefin Sans',
    fontWeight: FontWeight.w600,
    height: 1.5,
  );
  static const settingsInputTextFieldHintStyle = TextStyle(
    color: Color(0xFFBFBFBF),
    fontSize: 16,
    fontFamily: 'Josefin Sans',
    fontWeight: FontWeight.w600,
  );
  static const editProfileBoxShadow = BoxShadow(
    color: Color(0x19000000),
    blurRadius: 4,
    offset: Offset(1, 1),
    spreadRadius: 0,
  );
  static const termsAndPolicyStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
  );

  static const termsAndPolicyCheckTextStyle = TextStyle(
    color: AppColor.primaryBlue,
    fontSize: 13,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
  );
}
