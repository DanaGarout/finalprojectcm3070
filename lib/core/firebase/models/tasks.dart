import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  // Fields to store task-related information
  String? taskName; // Name of the task
  String? description; // Description of the task
  Timestamp? dueDate; // Due date of the task
  Timestamp? dueTime; // Due time of the task
  String? notes; // Additional notes for the task
  bool hasStarted; // Flag to indicate if the task has started
  bool inProgress; // Flag to indicate if the task is in progress
  bool isDone; // Flag to indicate if the task is completed
  bool isArchived; // Flag to indicate if the task is archived

  // Constructor to initialize the task fields
  Tasks({
    this.taskName,
    this.description,
    this.dueDate,
    this.dueTime,
    this.notes,
    required this.hasStarted,
    required this.inProgress,
    required this.isDone,
    this.isArchived = false, // Default value for isArchived is false
  });

  // Factory constructor to create a Tasks instance from JSON
  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        taskName: json['taskName'] as String?, // Extract task name from JSON
        description:
            json['description'] as String?, // Extract description from JSON
        dueDate: json['dueDate'] as Timestamp?, // Extract due date from JSON
        dueTime: json['dueTime'] as Timestamp?, // Extract due time from JSON
        notes: json['notes'] as String?, // Extract notes from JSON
        hasStarted: (json['hasStarted'] as bool?) ??
            false, // Extract or default hasStarted flag
        inProgress: (json['inProgress'] as bool?) ??
            false, // Extract or default inProgress flag
        isDone: (json['isDone'] as bool?) ??
            false, // Extract or default isDone flag
        isArchived: (json['isArchived'] as bool?) ??
            false, // Extract or default isArchived flag
      );

  // Method to convert a Tasks instance to JSON
  Map<String, dynamic> toJson() => {
        'taskName': taskName, // Convert task name to JSON
        'description': description, // Convert description to JSON
        'dueDate': dueDate, // Convert due date to JSON
        'dueTime': dueTime, // Convert due time to JSON
        'notes': notes, // Convert notes to JSON
        'hasStarted': hasStarted, // Convert hasStarted flag to JSON
        'inProgress': inProgress, // Convert inProgress flag to JSON
        'isDone': isDone, // Convert isDone flag to JSON
        'isArchived': isArchived, // Convert isArchived flag to JSON
      };
}
