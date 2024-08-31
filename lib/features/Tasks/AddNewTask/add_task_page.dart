import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/firebase/models/tasks.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/TasksStyles/tasks_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Tasks/AddNewTask/add_task_label_widget.dart';
import 'package:ultratasks/features/Tasks/AddNewTask/add_task_textfield_widget.dart';
import 'package:ultratasks/features/Tasks/AddNewTask/date_time_text_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController dueTimeController = TextEditingController();

  final DatabaseService databaseService = DatabaseService();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dueDateController.text =
            DateFormat('d MMMM y').format(picked); // Format selected date
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        dueTimeController.text =
            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}'; // Format selected time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    TasksConstants.newTasks,
                    style: TasksStyles.addTasksPageTitleTextStyle,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the modal
                    },
                  ),
                ],
              ),
              AppDimensions.sizedBoxH16,
              const AddTaskLabelWidget(
                labelText: TasksConstants.taskName,
              ),
              AddTaskTextfieldWidget(
                controller: taskController,
              ),
              AppDimensions.sizedBoxH16,
              const AddTaskLabelWidget(
                labelText: TasksConstants.dueDate,
              ),
              DateTimeTextField(
                onTap: () => _selectDate(context),
                controller: dueDateController,
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              AppDimensions.sizedBoxH16,
              const AddTaskLabelWidget(
                labelText: TasksConstants.dueTime,
              ),
              DateTimeTextField(
                onTap: () => _selectTime(context),
                controller: dueTimeController,
                suffixIcon: const Icon(Icons.access_time),
              ),
              AppDimensions.sizedBoxH16,
              const AddTaskLabelWidget(
                labelText: TasksConstants.description,
              ),
              AddTaskTextfieldWidget(
                controller: descController,
                maxLines: 4,
              ),
              AppDimensions.sizedBoxH16,
              const AddTaskLabelWidget(
                labelText: TasksConstants.notes,
              ),
              AddTaskTextfieldWidget(
                controller: notesController,
                maxLines: 4,
              ),
              AppDimensions.sizedBoxH16,
              ButtonCustomWidget(
                text: TasksConstants.addTask,
                buttonColor: AppColor.brown,
                onPressed: () {
                  if (selectedDate != null && selectedTime != null) {
                    final DateTime dueDateTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );

                    Tasks tasks = Tasks(
                      description: descController.text,
                      dueDate: Timestamp.fromDate(dueDateTime),
                      dueTime: Timestamp.fromDate(dueDateTime),
                      hasStarted: true,
                      inProgress: false,
                      isDone: false,
                      notes: notesController.text,
                      taskName: taskController.text,
                    );

                    if (kDebugMode) {
                      print(
                          'Attempting to add task: ${tasks.toJson()}'); // Debug: Log task details
                    }

                    databaseService.addTask(tasks).then((_) {
                      if (kDebugMode) {
                        print('Task added successfully'); // Debug: Log success
                      }
                      Navigator.of(context).pop();
                      taskController.clear();
                      notesController.clear();
                      descController.clear();
                      dueDateController.clear();
                      dueTimeController.clear();
                    }).catchError((e) {
                      if (kDebugMode) {
                        print('Failed to add task: $e'); // Debug: Log failure
                      }
                    });
                  } else {
                    if (kDebugMode) {
                      print(
                          'Date and/or time not selected'); // Debug: Log missing date/time
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
