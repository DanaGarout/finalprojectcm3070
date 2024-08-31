import 'package:flutter/material.dart';
import 'package:ultratasks/features/Profile/TasksProgressSection/done_tasks_widget.dart';
import 'package:ultratasks/features/Profile/TasksProgressSection/total_tasks_done_widget.dart';

class TasksProgressSection extends StatelessWidget {
  const TasksProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const TotalTasksDoneWidget(), // Display total tasks done
        DoneTasksWidget(), // Display done tasks widget
      ],
    );
  }
}
