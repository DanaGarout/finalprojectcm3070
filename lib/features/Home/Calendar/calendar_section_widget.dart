import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/subtitle_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/core/utils/constants.dart';

class CalendarSectionWidget extends StatelessWidget {
  const CalendarSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitleWidget(
          subtitle:
              HomeConstants.calendar, // Display title for the calendar section
        ),
        Center(
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type
                  .multi, // Allow selection of multiple dates
              weekdayLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
              weekdayLabelTextStyle: HomeStyles.weekdayLabelTextStyle,
              dayTextStyle: HomeStyles.dayTextStyle,
              selectedDayTextStyle: HomeStyles.selectedDayTextStyle,
            ),
            value: [DateTime.now()], // Default selected date is today
            onValueChanged: (dates) {
              if (dates.isNotEmpty) {
                // Handle date selection change
              }
            },
          ),
        ),
      ],
    );
  }
}
