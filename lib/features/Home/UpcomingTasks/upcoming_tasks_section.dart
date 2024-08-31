import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/subtitle_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/firebase/models/tasks.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Home/UpcomingTasks/home_task_field.dart';

class UpcomingTasksSection extends StatefulWidget {
  const UpcomingTasksSection({super.key});

  @override
  State<UpcomingTasksSection> createState() => _UpcomingTasksSectionState();
}

class _UpcomingTasksSectionState extends State<UpcomingTasksSection> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: databaseService
              .getActiveTasks(), // Get active tasks from Firestore
          builder: (context, snapshot) {
            List todos = snapshot.data?.docs ?? [];

            return Row(
              children: [
                const SectionTitleWidget(
                  subtitle: HomeConstants
                      .upcomingTasks, // Display title for upcoming tasks
                ),
                AppDimensions.sizedBoxW8,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: ShapeDecoration(
                    color: AppColor.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${todos.length} tasks',
                        style: HomeStyles
                            .taskNumberTextStyle, // Display the number of tasks
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        AppDimensions.sizedBoxH12,
        StreamBuilder(
          stream:
              databaseService.getActiveTasks(), // Stream to get active tasks
          builder: (context, snapshot) {
            List todos = snapshot.data?.docs ?? [];
            if (todos.isEmpty) {
              return const Center(
                child: Text(
                  HomeConstants.addATask, // Message when no tasks are available
                ),
              );
            }
            return SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: todos.length > 2
                    ? 2
                    : todos.length, // Limit to 2 tasks for display
                itemBuilder: (context, index) {
                  Tasks task = todos[index].data();
                  String todoId = todos[index].id;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: HomeTaskField(
                      taskId: todoId,
                      taskName: task.taskName ??
                          'No Title', // Default to "No Title" if not provided
                      taskDetail: task.description ??
                          'No Description', // Default to "No Description" if not provided
                      dueTime: task.dueTime ?? Timestamp.now(),
                      dueDate: task.dueDate ?? Timestamp.now(),
                      taskNotes: task.notes ??
                          'No Notes', // Default to "No Notes" if not provided
                      hasStarted: task.hasStarted,
                      inProgress: task.inProgress,
                      isDone: task.isDone,
                      onDelete: () {
                        databaseService
                            .archiveTask(todoId); // Archive task when deleted
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
