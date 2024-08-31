import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/custom_widgets/subtitle_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Chrono/WorldClock/world_clock_country.dart';
import 'package:ultratasks/features/Chrono/WorldClock/world_clock_page.dart';

class WorldClockSection extends StatefulWidget {
  const WorldClockSection({super.key});

  @override
  State<WorldClockSection> createState() => _WorldClockSectionState();
}

class _WorldClockSectionState extends State<WorldClockSection> {
  // List of locations to display in the World Clock section
  final List<Map<String, String>> _locations = [
    {'name': 'New York', 'timezone': 'America/New_York', 'countryCode': 'us'},
    {'name': 'Beijing', 'timezone': 'Asia/Shanghai', 'countryCode': 'cn'},
    {'name': 'Dubai', 'timezone': 'Asia/Dubai', 'countryCode': 'ae'},
  ];

  // Timer to update the time displayed every minute
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones(); // Initialize timezone data

    // Start a timer that updates the time every minute
    _timer =
        Timer.periodic(const Duration(minutes: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Function to update the UI when the time changes
  void _updateTime() {
    setState(() {});
  }

  // Navigate to the World Clock full display page
  void navigateToWorldDisplayPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const WorldClockPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and 'See more' link for the World Clock section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitleWidget(
              subtitle: ChronoConstants.worldCLock,
            ),
            GestureDetector(
              onTap: navigateToWorldDisplayPage,
              child: const Text(
                ChronoConstants.seeMore,
              ),
            )
          ],
        ),
        AppDimensions.sizedBoxH4,
        // Display the list of world clock entries
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12,
          ),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [Color(0xFF795548), Color(0xFFDF9C84)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              ChronoStyles.chronoBoxShadowStyle,
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _locations.map((location) {
              final tz.TZDateTime now =
                  tz.TZDateTime.now(tz.getLocation(location['timezone']!));
              final formattedTime = DateFormat('HH:mm').format(now);
              return WorldClockCountry(
                countryFlag: 'icons/flags/svg/${location['countryCode']}.svg',
                countryName: location['name'] ?? '',
                countryTime: formattedTime,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
