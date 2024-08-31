import 'dart:async';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/features/Chrono/WorldClock/world_clock_country.dart';
import 'country_data.dart';

class WorldClockDisplay extends StatefulWidget {
  const WorldClockDisplay({super.key});

  @override
  State<WorldClockDisplay> createState() => _WorldClockDisplayState();
}

class _WorldClockDisplayState extends State<WorldClockDisplay> {
  final TextEditingController _searchController =
      TextEditingController(); // Controller for the search bar
  late List<Map<String, String>>
      _filteredLocations; // List of filtered locations based on search query
  late Timer _timer; // Timer to update the time every minute

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones(); // Initialize timezone data

    _filteredLocations =
        worldLocations; // Initialize the filtered locations list

    // Start a timer that updates the time every minute
    _timer =
        Timer.periodic(const Duration(minutes: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the search controller
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Function to update the UI when the time changes
  void _updateTime() {
    setState(() {});
  }

  // Filter the locations based on the search query
  void _filterLocations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLocations =
            worldLocations; // Show all locations if search query is empty
      } else {
        _filteredLocations = worldLocations
            .where((location) =>
                location['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList(); // Filter locations based on the search query
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller:
                _searchController, // Attach search controller to the search bar
            decoration: const InputDecoration(
              labelStyle: ChronoStyles.chronoDescriptionParagraphStyle,
              labelText: 'Search Country',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.white)),
            ),
            onChanged:
                _filterLocations, // Update the filtered locations as the user types
          ),
        ),
        Center(
          child: Image.asset(
            ChronoAssetsPath
                .worldClockImage, // Display an image representing the world clock
          ),
        ),
        AppDimensions.sizedBoxH8,
        Expanded(
          child: ListView.builder(
            itemCount: _filteredLocations.length, // Number of items to display
            itemBuilder: (context, index) {
              final location =
                  _filteredLocations[index]; // Get the current location
              final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(location[
                  'timezone']!)); // Get the current time in the location's timezone
              final formattedTime = DateFormat('HH:mm')
                  .format(now); // Format the time for display
              return WorldClockCountry(
                countryFlag: 'icons/flags/svg/${location['countryCode']}.svg',
                countryName: location['name'] ?? '',
                countryTime: formattedTime,
              ); // Display the location's flag, name, and current time
            },
          ),
        ),
      ],
    );
  }
}
