import 'package:flutter/material.dart';
import 'package:ultratasks/features/Home/HomeTitles/name_greet_widget.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/features/Home/Calendar/calendar_section_widget.dart';
import 'package:ultratasks/features/Home/UpcomingTasks/upcoming_tasks_section.dart';
import 'package:ultratasks/features/Home/HomeTitles/home_title.dart';
import 'package:ultratasks/features/Weather/WeatherHomeSection/weather_section_widget.dart';
import 'package:ultratasks/features/TimeBlock/TimeBlockPage/time_block_section.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/water_intake_calculator_section.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.grey01,
        title: const HomeTitle(), // Display the app's title in the app bar
        centerTitle: true,
      ),
      backgroundColor: AppColor.grey01,
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.grey01,
          padding: const EdgeInsets.all(8.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameGreetWidget(), // Greet the user with their name
              AppDimensions.sizedBoxH4,
              UpcomingTasksSection(), // Show upcoming tasks
              AppDimensions.sizedBoxH12,
              CalendarSectionWidget(), // Display the calendar section
              AppDimensions.sizedBoxH12,
              WeatherSectionWidget(), // Display the weather section
              AppDimensions.sizedBoxH12,
              WaterIntakeCalculatorSection(), // Display water intake calculator
              AppDimensions.sizedBoxH12,
              TimeBlockSection(), // Display time block section
              AppDimensions.sizedBoxH12,
            ],
          ),
        ),
      ),
    );
  }
}
