import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/ProfileStyles/profile_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/utils/constants.dart';

class TotalTasksDoneWidget extends StatefulWidget {
  const TotalTasksDoneWidget({super.key});

  @override
  State<TotalTasksDoneWidget> createState() => _TotalTasksDoneWidgetState();
}

class _TotalTasksDoneWidgetState extends State<TotalTasksDoneWidget> {
  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseService
          .getActiveTasks(), // Listen for changes in active tasks
      builder: (context, snapshot) {
        List todos = snapshot.data?.docs ?? [];

        return Container(
          padding: const EdgeInsets.all(4),
          decoration: ShapeDecoration(
            color: AppColor.brownShadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            shadows: const [
              ProfileStyles.profileTaskDetailBoxShadow,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${todos.length}', // Display the number of active tasks
                style: ProfileStyles.profileTasksNumberStyle,
              ),
              AppDimensions.sizedBoxH8,
              const SizedBox(
                width: 69,
                child: Text(
                  ProfileConstants.pendingTasks,
                  textAlign: TextAlign.center,
                  style: ProfileStyles.profileBoxTitleTextStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
