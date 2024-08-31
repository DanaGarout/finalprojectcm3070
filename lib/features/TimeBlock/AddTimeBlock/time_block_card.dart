import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/TimeBlockStyles/time_block_styles.dart';

class TimeBlockCard extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final String duration;

  const TimeBlockCard({
    required this.title,
    required this.description,
    required this.time,
    required this.duration,
    super.key,
  });

  @override
  State<TimeBlockCard> createState() => _TimeBlockCardState();
}

class _TimeBlockCardState extends State<TimeBlockCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff529AD1),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.time, // Display the time of the time block
              style: TimeBlockStyles.timeBlockCardStyle,
            ),
            Text(
              widget.duration, // Display the duration of the time block
              style: TimeBlockStyles.durationBlockCardStyle,
            ),
          ],
        ),
        title: Text(
          widget.title, // Title of the time block
          style: TimeBlockStyles.titleBlockCardStyle,
        ),
        subtitle: Text(
          widget.description, // Description of the time block
          style: TimeBlockStyles.descriptionBlockCardStyle,
        ),
      ),
    );
  }
}
