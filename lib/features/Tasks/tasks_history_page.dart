import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/firebase/models/tasks.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Home/UpcomingTasks/home_task_field.dart';

class TasksHistoryPage extends StatefulWidget {
  const TasksHistoryPage({super.key});

  @override
  State<TasksHistoryPage> createState() => _TasksHistoryPageState();
}

class _TasksHistoryPageState extends State<TasksHistoryPage> {
  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: true,
      backgroundColor: AppColor.grey01,
      appBarColor: AppColor.grey01,
      pageTitle: TasksConstants.tasksHistory,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppDimensions.sizedBoxH8,
              StreamBuilder(
                stream:
                    databaseService.getArchivedTasks(), // Stream archived tasks
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No archived tasks available'));
                  }

                  List todos = snapshot.data!.docs;

                  return SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        Tasks task = todos[index].data();
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: HomeTaskField(
                            taskId: todos[index].id,
                            taskName: task.taskName ?? 'No Title',
                            taskDetail: task.description ?? 'No Description',
                            dueTime: task.dueTime ?? Timestamp.now(),
                            dueDate: task.dueDate ?? Timestamp.now(),
                            taskNotes: task.notes ?? 'No Notes',
                            hasStarted: task.hasStarted,
                            inProgress: task.inProgress,
                            isDone: true, // Display as done in history
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
