import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/TimeBlockStyles/time_block_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/TimeBlock/AddTimeBlock/add_time_block_form.dart';
import 'package:ultratasks/features/TimeBlock/AddTimeBlock/time_block_card.dart';

class TimeBlockPage extends StatefulWidget {
  const TimeBlockPage({super.key});

  @override
  State<TimeBlockPage> createState() => _TimeBlockPageState();
}

class _TimeBlockPageState extends State<TimeBlockPage> {
  final DateTime _selectedDay = DateTime.now();
  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _dbService.initializeUserTasks(); // Initialize user tasks in database
  }

  void _addTimeBlock(
      String title, String description, String time, String duration) {
    final newBlock = {
      'title': title,
      'description': description,
      'time': time,
      'duration': duration,
    };
    _dbService.addTimeBlock(newBlock); // Add time block to the database
  }

  void _openAddTimeBlockModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xffE6A4B4),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.65,
        minChildSize: 0.65,
        maxChildSize: 1.0,
        builder: (_, controller) => AddTimeBlockForm(
          onSubmit: _addTimeBlock, // Submit the form data
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format date and day of the week
    String formattedDate =
        "${_selectedDay.day} ${_getMonthName(_selectedDay.month)} ${_selectedDay.year}";
    String dayOfWeek = _getDayOfWeek(_selectedDay.weekday);

    return CustomScaffold(
      automaticallyImplyLeading: true,
      appBarColor: const Color(0xffF5EEE6),
      backgroundColor: const Color(0xffF5EEE6),
      pageTitle: TimeBlockConstants.timeBlock,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              TimeBlockConstants.todayBlock,
              style: TimeBlockStyles.dateTodayStyle,
            ),
            AppDimensions.sizedBoxH8,
            Text(
              '$dayOfWeek, $formattedDate', // Display day and date
              style: TimeBlockStyles.todaysDateStyle,
            ),
            AppDimensions.sizedBoxH20,
            Image.asset(
              TimeBlockAssetsPath.timeBlockImage,
            ),
            AppDimensions.sizedBoxH20,
            ButtonCustomWidget(
              text: TimeBlockConstants.addTimeBlock,
              buttonColor: AppColor.pink,
              onPressed: () => _openAddTimeBlockModal(
                  context), // Open modal to add a new block
            ),
            AppDimensions.sizedBoxH10,
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _dbService
                    .getTimeBlocks(), // Stream of time blocks from Firestore
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final timeBlocks = snapshot.data?.docs ?? [];

                  return ListView.builder(
                    itemCount: timeBlocks.length,
                    itemBuilder: (context, index) {
                      final block = timeBlocks[index].data();
                      return TimeBlockCard(
                        title: block['title'] ?? '',
                        description: block['description'] ?? '',
                        time: block['time'] ?? '',
                        duration: block['duration'] ?? '',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get the month name based on the month number
  String _getMonthName(int month) {
    TimeBlockConstants.months;
    return TimeBlockConstants.months[month - 1];
  }

  // Get the day name based on the weekday number
  String _getDayOfWeek(int weekday) {
    TimeBlockConstants.days;
    return TimeBlockConstants.days[weekday - 1];
  }
}
