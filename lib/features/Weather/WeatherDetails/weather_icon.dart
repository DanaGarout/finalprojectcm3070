import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_functions.dart';

class WeatherIcon extends StatefulWidget {
  final double width; // Width of the weather icon
  final double height; // Height of the weather icon

  const WeatherIcon({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<WeatherIcon> createState() => _WeatherIconState();
}

class _WeatherIconState extends State<WeatherIcon> {
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
    final weatherIcon =
        _weatherData?.currentWeather.weatherIcon; // Get the weather icon URL
    if (weatherIcon == null) {
      return const SizedBox
          .shrink(); // Return an empty widget or placeholder if no icon is available
    }
    return Image.network(
      'http://openweathermap.org/img/wn/$weatherIcon@4x.png', // Display the weather icon from the URL
      width: widget.width,
      height: widget.height,
    );
  }
}
