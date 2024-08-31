import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Chrono/WorldClock/world_clock_display.dart';

class WorldClockPage extends StatelessWidget {
  const WorldClockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: true, // Automatically show the back button
      pageTitle: ChronoConstants.worldCLock, // Title of the page
      backgroundColor: AppColor.brownLighten0,
      appBarColor: AppColor.brownLighten0,
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              AppColor.brownLighten0,
              AppColor.darkBrown,
            ],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Expanded(
            child: WorldClockDisplay(), // Display the World Clock content
          ),
        ),
      ),
    );
  }
}
