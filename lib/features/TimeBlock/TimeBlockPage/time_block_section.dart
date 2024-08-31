import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultratasks/core/custom_widgets/subtitle_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/TimeBlockStyles/time_block_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/TimeBlock/TimeBlockPage/time_block_page.dart';

class TimeBlockSection extends StatelessWidget {
  const TimeBlockSection({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToTimeBlockScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const TimeBlockPage(), // Navigate to TimeBlockPage
        ),
      );
    }

    final DateTime selectedDay = DateTime.now();

    // Format date and day of the week
    String formattedDate =
        "${selectedDay.day} ${_getMonthName(selectedDay.month)} ${selectedDay.year}";
    String dayOfWeek = _getDayOfWeek(selectedDay.weekday);

    return GestureDetector(
      onTap: navigateToTimeBlockScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitleWidget(
            subtitle: TimeBlockConstants.myTimeBlock, // Title of the section
          ),
          AppDimensions.sizedBoxH8,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(1.00, 0.06),
                end: Alignment(-1, -0.06),
                colors: [Color(0xFFCD6880), Color(0xFFE6A4B4)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      TimeBlockConstants.planYourDay, // Heading inside the card
                      style: TimeBlockStyles.descStyle,
                    ),
                    Text(
                      '$dayOfWeek, $formattedDate', // Display day and date
                      style: TimeBlockStyles.todaysDateStyle ,
                    ),
                  ],
                ),
                SvgPicture.asset(
                  ChronoAssetsPath.timerIcon,
                  colorFilter: const ColorFilter.mode(
                    AppColor.darkBrown,
                    BlendMode.srcIn,
                  ),
                )
              ],
            ),
          ),
        ],
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
