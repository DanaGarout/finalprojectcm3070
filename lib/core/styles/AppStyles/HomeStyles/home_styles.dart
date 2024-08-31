import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_color.dart';

class HomeStyles {
  // Home Title Styles
  static const homeTitleBoxShadowStyle = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 4,
    offset: Offset(2, 2),
    spreadRadius: 0,
  );
  static const ultraTaskTitleTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 32,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  // UpComing Task Styles
  static const nameGreetTitleStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static const sectionTitleWidgetStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static const taskNumberTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w600,
    height: 0,
  );
  static const homeStyleBoxShadowStyle = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 4,
    offset: Offset(2, 2),
    spreadRadius: 0,
  );
  static const taskNameStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  static const taskDetailStyle = TextStyle(
    color: Color(0xFF795548),
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
  );
  static const dueDateStyle = TextStyle(
    color: Color(0xFF693636),
    fontSize: 12,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0.14,
    letterSpacing: 0.14,
  );
  static const selectedTaskProgressStyle = TextStyle(
    color: Color(0xFF795548),
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    letterSpacing: 0.14,
  );
  static const unSelectedTaskProgressStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    letterSpacing: 0.14,
  );
  // Calendar Section Styles
  static const weekdayLabelTextStyle = TextStyle(
    color: AppColor.brown,
    fontSize: 15.65,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w600,
    height: 0.08,
  );

  static const dayTextStyle = TextStyle(
    color: Color(0xFF7C86A2),
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static const selectedDayTextStyle = TextStyle(
    color: Colors.white,
  );

  // Weather Section Styles

  static const weatherDegreeTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w800,
    height: 0,
  );
  static const weatherDefaultTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w400,
    height: 0,
  );
  static const weatherTodayTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w400,
    height: 0,
  );
}
