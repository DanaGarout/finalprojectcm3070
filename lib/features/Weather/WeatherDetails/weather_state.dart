import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_functions.dart';

class WeatherState extends StatefulWidget {
  final TextStyle style; // Text style for displaying the weather state
  const WeatherState({
    super.key,
    required this.style,
  });

  @override
  State<WeatherState> createState() => _WeatherStateState();
}

class _WeatherStateState extends State<WeatherState> {
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
      _weatherData?.currentWeather.weatherDescription ??
          "", // Display the weather description (e.g., Clear, Rain)
      textAlign: TextAlign.center,
      style: widget.style,
    );
  }
}
