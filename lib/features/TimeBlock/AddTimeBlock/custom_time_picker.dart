import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/styles/AppStyles/TimeBlockStyles/time_block_styles.dart';

class CustomTimePicker extends StatelessWidget {
  final String label;
  final String initialTime;
  final Function(String) onTimeChanged;

  const CustomTimePicker({
    super.key,
    required this.label,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // Label for the time picker
          style: TimeBlockStyles.customLabelPickerStyle,
        ),
        const SizedBox(height: 8),
        TimePickerSpinner(
          time: _parseTime(initialTime), // Initialize the time picker
          is24HourMode: true,
          normalTextStyle: TimeBlockStyles.customNormalTextStyle,
          highlightedTextStyle: TimeBlockStyles.customHightlightedTextStyle,
          isForce2Digits: true,
          onTimeChange: (time) {
            final formattedTime = _formatTime(time); // Format selected time
            onTimeChanged(formattedTime);
          },
        ),
      ],
    );
  }

  DateTime _parseTime(String time) {
    final format = DateFormat.Hm(); // 24-hour format
    return format.parse(time);
  }

  String _formatTime(DateTime time) {
    final format = DateFormat.Hm(); // 24-hour format
    return format.format(time);
  }
}
