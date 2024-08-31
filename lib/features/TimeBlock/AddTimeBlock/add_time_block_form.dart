import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/styles/AppStyles/TimeBlockStyles/time_block_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/TimeBlock/AddTimeBlock/custom_time_picker.dart';

class AddTimeBlockForm extends StatefulWidget {
  final Function(String, String, String, String) onSubmit;

  const AddTimeBlockForm({required this.onSubmit, super.key});

  @override
  State<AddTimeBlockForm> createState() => _AddTimeBlockFormState();
}

class _AddTimeBlockFormState extends State<AddTimeBlockForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _startTime = '09:40 AM';
  String _endTime = '10:40 AM';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              TimeBlockConstants.addTimeBlock, // Form title
              style: TimeBlockStyles.addTimeStyle,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTimePicker(
                    label: TimeBlockConstants.from, // Label for start time
                    initialTime: _startTime,
                    onTimeChanged: (time) {
                      setState(() {
                        _startTime = time;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTimePicker(
                    label: TimeBlockConstants.to, // Label for end time
                    initialTime: _endTime,
                    onTimeChanged: (time) {
                      setState(() {
                        _endTime = time;
                      });
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: TimeBlockConstants.title, // Title field label
                labelStyle: TimeBlockStyles.timeBlockLabelStyle,
              ),
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText:
                    TasksConstants.description, // Description field label
                labelStyle: TimeBlockStyles.timeBlockLabelStyle,
              ),
              onSaved: (value) {
                _description = value!;
              },
            ),
            const SizedBox(height: 20),
            ButtonCustomWidget(
              text: TimeBlockConstants.saveBlock,
              buttonColor: AppColor.brown,
              onPressed: () {
                if (_validateTimeFields()) {
                  _formKey.currentState?.save();
                  final duration = _calculateDuration(_startTime, _endTime);
                  widget.onSubmit(_title, _description, _startTime, duration);
                  Navigator.of(context).pop(); // Close the modal
                } else {
                  _showValidationError();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  bool _validateTimeFields() {
    if (_startTime.isEmpty || _endTime.isEmpty) {
      return false;
    }

    final startTime = _parseTime(_startTime);
    final endTime = _parseTime(_endTime);

    if (startTime.isAfter(endTime)) {
      return false; // Start time should be before end time
    }

    return true;
  }

  void _showValidationError() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(TimeBlockConstants.invalidBlock),
          content: const Text(TimeBlockConstants
              .alertContent), // Error message for invalid time block
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                TimeBlockConstants.ok,
              ),
            ),
          ],
        );
      },
    );
  }

  String _calculateDuration(String start, String end) {
    final startTime = _parseTime(start);
    final endTime = _parseTime(end);

    final duration = endTime.difference(startTime); // Calculate time difference

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return "${hours > 0 ? '$hours hr ' : ''}$minutes min"; // Format duration
  }

  DateTime _parseTime(String time) {
    final format = DateFormat.Hm(); // 24-hour format
    try {
      return format.parse(time);
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing time: $time. Error: $e');
      }
      return DateTime.now(); // Fallback to now if parsing fails
    }
  }
}
