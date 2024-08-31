import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/features/Tasks/TasksDetails/task_description_page.dart';

class HomeTaskField extends StatefulWidget {
  final String taskId;
  final String taskName;
  final String taskDetail;
  final Timestamp dueDate;
  final Timestamp? dueTime;
  final String? taskNotes;
  final bool hasStarted;
  final bool inProgress;
  final bool isDone;
  final Function? onDelete;

  const HomeTaskField({
    super.key,
    required this.taskId,
    required this.taskName,
    required this.taskDetail,
    required this.dueDate,
    this.dueTime,
    this.taskNotes,
    this.hasStarted = false,
    this.inProgress = false,
    this.isDone = false,
    this.onDelete,
  });

  @override
  State<HomeTaskField> createState() => _HomeTaskFieldState();
}

class _HomeTaskFieldState extends State<HomeTaskField> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();

    // Set the initial selected index based on the task status
    if (widget.isDone) {
      _selectedIndex = 2;
    } else if (widget.inProgress) {
      _selectedIndex = 1;
    } else {
      _selectedIndex = 0;
    }
  }

  void _updateTaskStatus(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Update the task status in Firestore
    final updatedData = {
      'hasStarted': index == 0,
      'inProgress': index == 1,
      'isDone': index == 2,
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('tasks')
        .doc(widget.taskId)
        .update(updatedData);

    // If task is marked as done, trigger deletion after 3 seconds
    if (index == 2 && widget.onDelete != null) {
      Timer(const Duration(seconds: 3), () {
        widget.onDelete!();
      });
    }
  }

  void navigateToTaskDescription() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDescriptionPage(
          taskName: widget.taskName,
          taskDetail: widget.taskDetail,
          dueDate: widget.dueDate,
          dueTime: widget.dueTime,
          taskNotes: widget.taskNotes ?? '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dueDate = widget.dueDate.toDate();
    String formattedDate = DateFormat('d MMMM').format(dueDate);

    return GestureDetector(
      onTap: navigateToTaskDescription,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: ShapeDecoration(
          color: AppColor.pink,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: AppColor.orange,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            HomeStyles.homeStyleBoxShadowStyle,
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskName,
              style: HomeStyles.taskNameStyle, // Display the task name
            ),
            Text(
              widget.taskDetail,
              style: HomeStyles.taskDetailStyle, // Display the task details
            ),
            AppDimensions.sizedBoxH6,
            Row(
              children: [
                SvgPicture.asset(
                  HomeAssetsPath.calendarIcon,
                ),
                AppDimensions.sizedBoxW4,
                Text(
                  formattedDate,
                  style: HomeStyles.dueDateStyle, // Display the due date
                ),
              ],
            ),
            AppDimensions.sizedBoxH6,
            Row(
              children: [
                _buildButton(
                    0, 'Not Started'), // Button for "Not Started" status
                AppDimensions.sizedBoxW4,
                _buildButton(
                    1, 'In Progress'), // Button for "In Progress" status
                AppDimensions.sizedBoxW4,
                _buildButton(2, 'Done'), // Button for "Done" status
              ],
            ),
            AppDimensions.sizedBoxW8,
          ],
        ),
      ),
    );
  }

  Widget _buildButton(int index, String text) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (_selectedIndex != 2 || text == 'Done') {
          _updateTaskStatus(index);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: ShapeDecoration(
          color: isSelected ? AppColor.brown : AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(61),
          ),
        ),
        child: Text(
          text,
          style: isSelected
              ? HomeStyles.unSelectedTaskProgressStyle
              : HomeStyles
                  .selectedTaskProgressStyle, // Style based on selection
        ),
      ),
    );
  }
}
