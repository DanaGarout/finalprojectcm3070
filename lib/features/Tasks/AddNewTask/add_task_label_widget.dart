import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/TasksStyles/tasks_styles.dart';

class AddTaskLabelWidget extends StatelessWidget {
  final String labelText;
  const AddTaskLabelWidget({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText,
      style: TasksStyles.addTaskLabelStyle,
    );
  }
}
