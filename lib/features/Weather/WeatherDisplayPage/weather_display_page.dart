import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/WeatherStyles/weather_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/current_weather.dart';
import 'package:ultratasks/features/Weather/WeatherDisplayPage/weather_by_hour_widget.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_functions.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/weather_icon.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/weather_location.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/weather_state.dart';

class WeatherDisplayPage extends StatefulWidget {
  const WeatherDisplayPage({super.key});

  @override
  State<WeatherDisplayPage> createState() => _WeatherDisplayPageState();
}

class _WeatherDisplayPageState extends State<WeatherDisplayPage> {
  final WeatherService _weatherService =
      WeatherService(); // Weather service to fetch data
  WeatherData? _weatherData; // Stores the fetched weather data

  @override
  void initState() {
    super.initState();
    _loadWeather(); // Load weather data when the widget is initialized
  }

  // Fetches the current weather based on the user's location
  Future<void> _loadWeather() async {
    Position? position = await _weatherService.getCurrentLocation();
    if (position != null) {
      WeatherData? weatherData = await _weatherService.fetchWeather(
          position.latitude, position.longitude);
      setState(() {
        _weatherData = weatherData; // Update the state with the fetched data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherData == null) {
      return const Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      );
    }
    return CustomScaffold(
      automaticallyImplyLeading: true,
      pageTitle: WeatherConstants.weather,
      backgroundColor: const Color(0xFF4BC8FC),
      appBarColor: const Color(0xFF4BC8FC),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF4BC8FC), Color(0xFF003D75)],
            ),
          ),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WeatherIcon(
                    height: 100, width: 100), // Display the weather icon
                AppDimensions.sizedBoxH8,
                WeatherLocation(
                  style: WeatherStyles
                      .weatherLocationStyle, // Display the location
                ),
                AppDimensions.sizedBoxH8,
                CurrentWeather(
                  style: WeatherStyles
                      .currentWeatherDisplayStyle, // Display the current weather
                ),
                WeatherState(
                  style: WeatherStyles
                      .weatherStateStyle, // Display the weather state (e.g., Sunny, Rainy)
                ),
                AppDimensions.sizedBoxH16,
                AppDimensions.sizedBoxH20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        WeatherConstants
                            .todaysTemp, // Title for the hourly temperature section
                        style: WeatherStyles.todaysTitleStyle,
                      ),
                    ],
                  ),
                ),
                AppDimensions.sizedBoxH20,
                WeatherByHourWidget() // Display the hourly weather data
              ],
            ),
          ),
        ),
      ),
    );
  }
}
