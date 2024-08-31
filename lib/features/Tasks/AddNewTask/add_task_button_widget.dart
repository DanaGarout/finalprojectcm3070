import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/TasksStyles/tasks_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Tasks/AddNewTask/add_task_page.dart';

class AddTaskButtonWidget extends StatelessWidget {
  void _openAddTaskModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.80,
        minChildSize: 0.80,
        maxChildSize: 1.0,
        builder: (_, controller) => const AddTaskPage(),
      ),
    );
  }

  const AddTaskButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.brown,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => _openAddTaskModal(context), // Open modal to add task
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              TasksConstants.addTask,
              style: TasksStyles.addTaskButtonTextStyle,
            ),
            AppDimensions.sizedBoxW8,
            Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
