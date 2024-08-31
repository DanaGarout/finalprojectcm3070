import 'package:flutter/material.dart';

class TasksStyles {
  // Tasks Search Widget
  static const tasksScreenPageBoxShadow = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 4,
    offset: Offset(2, 2),
    spreadRadius: 0,
  );
  static const tasksSearchHintStyle = TextStyle(
    color: Color(0xFF7F7F7F),
    fontSize: 16,
    fontWeight: FontWeight.w300,
    height: 1,
  );
  // Sort Icon Style
  static const sortByTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Josefin Sans',
    fontWeight: FontWeight.w300,
    height: 0,
  );
  // Filter Icon Style
  static const filterTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Josefin Sans',
    fontWeight: FontWeight.w300,
    height: 0,
  );
  // Add Tasks Widget Styles
  static const addTaskButtonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const addTasksPageTitleTextStyle = TextStyle(
    color: Color(0xFF795548),
    fontSize: 32,
    fontFamily: 'Jost',
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  static const addTaskLabelStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
  static const tasksDescDateDueTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    height: 0,
  );
  
  
  static const tasksDescTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    height: 0,
  );
  static const tasksDescTaskDetailTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
  );

}
