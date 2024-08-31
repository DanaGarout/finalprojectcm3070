import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/firebase/models/tasks.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Home/UpcomingTasks/home_task_field.dart';
import 'package:ultratasks/features/Tasks/AddNewTask/add_task_button_widget.dart';
import 'package:ultratasks/features/Tasks/tasks_history_page.dart';

class TasksScreenPage extends StatefulWidget {
  const TasksScreenPage({super.key});

  @override
  State<TasksScreenPage> createState() => _TasksScreenPageState();
}

class _TasksScreenPageState extends State<TasksScreenPage> {
  final DatabaseService databaseService = DatabaseService();
  void navigateToTaskHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              const TasksHistoryPage()), // Navigate to task history
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.grey01,
      appBarColor: AppColor.grey01,
      pageTitle: TasksConstants.tasks,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppDimensions.sizedBoxH8,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const AddTaskButtonWidget(),
                  AppDimensions.sizedBoxW8,
                  ButtonCustomWidget(
                    text: TasksConstants.tasksHistory,
                    onPressed: navigateToTaskHistory,
                    buttonColor: AppColor.brandBlue,
                  ),
                ],
              ),
              AppDimensions.sizedBoxH8,
              StreamBuilder(
                stream: databaseService.getActiveTasks(), // Stream active tasks
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No tasks available'));
                  }

                  List todos = snapshot.data!.docs;

                  if (kDebugMode) {
                    print(
                        'Retrieved ${todos.length} tasks'); // Debug: Log number of tasks retrieved
                  }

                  return SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: todos.length,
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
                            taskName: task.taskName ?? 'No Title',
                            taskDetail: task.description ?? 'No Description',
                            dueTime: task.dueTime ?? Timestamp.now(),
                            dueDate: task.dueDate ?? Timestamp.now(),
                            taskNotes: task.notes ?? 'No Notes',
                            hasStarted: task.hasStarted,
                            inProgress: task.inProgress,
                            isDone: task.isDone,
                            onDelete: () {
                              databaseService.archiveTask(
                                  todoId); // Archive task on delete
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
