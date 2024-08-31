import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/TasksStyles/tasks_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';

import '../../../core/styles/app_dimensions.dart';

class TaskDescriptionPage extends StatelessWidget {
  final String taskName;
  final String taskDetail;
  final String taskNotes;
  final Timestamp? dueDate;
  final Timestamp? dueTime;

  const TaskDescriptionPage({
    super.key,
    required this.taskName,
    required this.taskDetail,
    this.dueDate,
    this.dueTime,
    required this.taskNotes,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDueDate = dueDate != null
        ? DateFormat('d MMMM y').format(dueDate!.toDate())
        : "No due date"; // Format due date

    String formattedDueTime = dueTime != null
        ? "${dueTime!.toDate().hour.toString().padLeft(2, '0')}:${dueTime!.toDate().minute.toString().padLeft(2, '0')}"
        : "No due time"; // Format due time

    return CustomScaffold(
      automaticallyImplyLeading: true,
      pageTitle: taskName,
      backgroundColor: AppColor.grey01,
      appBarColor: AppColor.grey01,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDimensions.sizedBoxH8,
            Center(
              child: SvgPicture.asset(
                TasksAssetsPath.taskDetailImage,
              ),
            ),
            AppDimensions.sizedBoxH8,
            const Text(
              TasksConstants.dueDate,
              style: TasksStyles.tasksDescTextStyle,
            ),
            AppDimensions.sizedBoxH4,
            Text(
              formattedDueDate,
              style: TasksStyles.tasksDescTaskDetailTextStyle,
            ),
            AppDimensions.sizedBoxH8,
            const Text(
              TasksConstants.dueTime,
              style: TasksStyles.tasksDescTextStyle,
            ),
            AppDimensions.sizedBoxH4,
            Text(
              formattedDueTime,
              style: TasksStyles.tasksDescTaskDetailTextStyle,
            ),
            AppDimensions.sizedBoxH8,
            const Text(
              TasksConstants.description,
              style: TasksStyles.tasksDescTextStyle,
            ),
            AppDimensions.sizedBoxH4,
            Text(
              taskDetail,
              style: TasksStyles.tasksDescTaskDetailTextStyle,
            ),
            AppDimensions.sizedBoxH8,
            const Text(
              TasksConstants.notes,
              style: TasksStyles.tasksDescTextStyle,
            ),
            AppDimensions.sizedBoxH4,
            Text(
              taskNotes,
              style: TasksStyles.tasksDescTaskDetailTextStyle,
            ),
            AppDimensions.sizedBoxH8,
          ],
        ),
      ),
    );
  }
}
