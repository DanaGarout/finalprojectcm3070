import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_functions.dart';

class CurrentWeather extends StatefulWidget {
  final TextStyle style; // Text style for displaying the weather
  const CurrentWeather({
    super.key,
    required this.style,
  });

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
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
    return Text(
      "${_weatherData?.currentWeather.temperature?.celsius?.toStringAsFixed(0)}° C", // Display the current temperature in Celsius
      textAlign: TextAlign.center,
      style: widget.style,
    );
  }
}
