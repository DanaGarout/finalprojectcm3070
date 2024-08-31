import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/weather_icon.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/weather_state.dart';

class WeatherIconState extends StatelessWidget {
  const WeatherIconState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WeatherIcon(
          height: 53,
          width: 53,
        ), // Display the weather icon
        WeatherState(
          style: HomeStyles.weatherTodayTextStyle,
        ), // Display the current weather state (e.g., Sunny, Rainy)
      ],
    );
  }
}
