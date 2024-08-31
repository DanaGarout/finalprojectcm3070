import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_functions.dart';

class WeatherLocation extends StatefulWidget {
  final TextStyle style; // Text style for displaying the location
  const WeatherLocation({
    super.key,
    required this.style,
  });

  @override
  State<WeatherLocation> createState() => _WeatherLocationState();
}

class _WeatherLocationState extends State<WeatherLocation> {
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
    String city = _weatherData?.currentWeather.areaName ??
        "Unknown Location"; // Get the city name
    String country = _weatherData?.currentWeather.country ??
        "Unknown Country"; // Get the country name
    return Text(
      "$city, $country", // Display the location (city, country)
      textAlign: TextAlign.center,
      style: HomeStyles.weatherDefaultTextStyle,
    );
  }
}
