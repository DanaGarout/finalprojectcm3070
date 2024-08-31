import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ultratasks/core/firebase/models/tasks.dart';

class DatabaseService {
  // Singleton pattern for DatabaseService
  static final DatabaseService _instance = DatabaseService._internal();

  // Factory constructor for singleton instance
  factory DatabaseService() {
    return _instance;
  }

  // Private constructor for singleton
  DatabaseService._internal();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // References to Firestore collections
  CollectionReference<Tasks>? _tasksRef;
  CollectionReference<Map<String, dynamic>>? _timeBlocksRef;
  CollectionReference<Map<String, dynamic>>? _userDetailsRef;

  // Counter for tracking the number of deleted tasks
  int _deletedTasksCount = 0;

  // Initialize Firestore references based on the logged-in user
  void initializeUserTasks() {
    User? user = _auth.currentUser;

    if (user != null) {
      // Initialize references for the user's tasks, timeblocks, and details collections
      _tasksRef = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .withConverter<Tasks>(
            fromFirestore: (snapshots, _) => Tasks.fromJson(snapshots.data()!),
            toFirestore: (task, _) => task.toJson(),
          );

      _timeBlocksRef =
          _firestore.collection('users').doc(user.uid).collection('timeblocks');

      _userDetailsRef =
          _firestore.collection('users').doc(user.uid).collection('details');

      // Debug log for initialization
      if (kDebugMode) {
        print(
            'Task, Timeblock, and User Details references initialized for user: ${user.uid}');
      }
    } else {
      // Clear references if no user is logged in
      _tasksRef = null;
      _timeBlocksRef = null;
      _userDetailsRef = null;
      if (kDebugMode) {
        print('No user is logged in');
      }
    }
  }

  // Stream to get active tasks (not archived)
  Stream<QuerySnapshot<Tasks>> getActiveTasks() {
    if (_tasksRef != null) {
      return _tasksRef!.where('isArchived', isEqualTo: false).snapshots();
    } else {
      return const Stream.empty();
    }
  }

  // Stream to get archived tasks
  Stream<QuerySnapshot<Tasks>> getArchivedTasks() {
    if (_tasksRef != null) {
      return _tasksRef!.where('isArchived', isEqualTo: true).snapshots();
    } else {
      return const Stream.empty();
    }
  }

  // Method to add a new task
  Future<void> addTask(Tasks task) async {
    if (_tasksRef != null) {
      await _tasksRef!.add(task).then((_) {
        if (kDebugMode) {
          print('Task added: ${task.taskName}');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to add task: $error');
        }
      });
    } else {
      if (kDebugMode) {
        print('Task reference is not initialized');
      }
    }
  }

  // Method to update an existing task
  Future<void> updateTask(String taskId, Tasks task) async {
    if (_tasksRef != null) {
      await _tasksRef!.doc(taskId).update(task.toJson()).then((_) {
        if (kDebugMode) {
          print('Task updated: ${task.taskName}');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to update task: $error');
        }
      });
    }
  }

  // Method to archive a task
  Future<void> archiveTask(String taskId) async {
    if (_tasksRef != null) {
      await _tasksRef!.doc(taskId).update({'isArchived': true}).then((_) {
        if (kDebugMode) {
          print('Task archived: $taskId');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to archive task: $error');
        }
      });
    }
  }

  // Method to delete a task
  Future<void> deleteTask(String taskId) async {
    if (_tasksRef != null) {
      await _tasksRef!.doc(taskId).delete().then((_) {
        _deletedTasksCount++;
        if (kDebugMode) {
          print('Task deleted: $taskId');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to delete task: $error');
        }
      });
    }
  }

  // Method to get the count of deleted tasks
  int getDeletedTasksCount() {
    return _deletedTasksCount;
  }

  // Method to add a new timeblock
  Future<void> addTimeBlock(Map<String, String> timeBlock) async {
    if (_timeBlocksRef != null) {
      await _timeBlocksRef!.add(timeBlock).then((_) {
        if (kDebugMode) {
          print('TimeBlock added: ${timeBlock['title']}');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to add timeblock: $error');
        }
      });
    } else {
      if (kDebugMode) {
        print('Timeblock reference is not initialized');
      }
    }
  }

  // Stream to get timeblocks for the current user
  Stream<QuerySnapshot<Map<String, dynamic>>> getTimeBlocks() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('timeblocks')
          .orderBy('time', descending: false)
          .snapshots();
    } else {
      return const Stream.empty();
    }
  }

  // Method to update an existing timeblock
  Future<void> updateTimeBlock(
      String blockId, Map<String, String> timeBlock) async {
    if (_timeBlocksRef != null) {
      await _timeBlocksRef!.doc(blockId).update(timeBlock).then((_) {
        if (kDebugMode) {
          print('TimeBlock updated: ${timeBlock['title']}');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to update timeblock: $error');
        }
      });
    } else {
      if (kDebugMode) {
        print('Timeblock reference is not initialized');
      }
    }
  }

  // Method to delete a timeblock
  Future<void> deleteTimeBlock(String blockId) async {
    if (_timeBlocksRef != null) {
      await _timeBlocksRef!.doc(blockId).delete().then((_) {
        if (kDebugMode) {
          print('TimeBlock deleted: $blockId');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to delete timeblock: $error');
        }
      });
    } else {
      if (kDebugMode) {
        print('Timeblock reference is not initialized');
      }
    }
  }

  // Method to save user water intake data
  Future<void> saveUserWaterIntakeData({
    required double height,
    required double weight,
    required String gender,
    required String weightUnit,
    required String heightUnit,
    required double waterIntake,
    required int waterCups,
  }) async {
    if (_userDetailsRef != null) {
      await _userDetailsRef!.doc('waterIntake').set({
        'height': height,
        'weight': weight,
        'gender': gender,
        'weightUnit': weightUnit,
        'heightUnit': heightUnit,
        'waterIntake': waterIntake,
        'waterCups': waterCups,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        if (kDebugMode) {
          print('User water intake data saved');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to save user water intake data: $error');
        }
      });
    }
  }

  // Method to get user water intake data
  Future<Map<String, dynamic>?> getUserWaterIntakeData() async {
    if (_userDetailsRef != null) {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _userDetailsRef!.doc('waterIntake').get();
      return doc.data();
    }
    return null;
  }

  // Method to delete user water intake data
  Future<void> deleteUserWaterIntakeData() async {
    if (_userDetailsRef != null) {
      await _userDetailsRef!.doc('waterIntake').delete().then((_) {
        if (kDebugMode) {
          print('User water intake data deleted');
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Failed to delete user water intake data: $error');
        }
      });
    }
  }

  // Method to save the state of water cups (for tracking intake)
  Future<void> saveCupsState(List<bool> cupsState) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('details')
          .doc('cupsState')
          .set({'cups': cupsState.map((e) => e ? 1 : 0).toList()});
    }
  }

  // Method to retrieve the state of water cups
  Future<List<bool>> getCupsState(int numberOfCups) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('details')
          .doc('cupsState')
          .get();
      if (snapshot.exists && snapshot.data() != null) {
        List<int> cupsState = List<int>.from(
            snapshot.data()?['cups'] ?? List.filled(numberOfCups, 0));
        return cupsState.map((e) => e == 1).toList();
      }
    }
    return List<bool>.filled(numberOfCups, false);
  }
}
