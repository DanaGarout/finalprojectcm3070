import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/current_weather.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_functions.dart';
import 'package:ultratasks/features/Weather/WeatherDetails/weather_location.dart';

class CurrentWeatherWidget extends StatefulWidget {
  const CurrentWeatherWidget({super.key});

  @override
  State<CurrentWeatherWidget> createState() => _CurrentWeatherWidgetState();
}

class _CurrentWeatherWidgetState extends State<CurrentWeatherWidget> {
  final WeatherService _weatherService =
      WeatherService(); // Weather service to fetch weather data
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CurrentWeather(
          style: HomeStyles
              .weatherDegreeTextStyle, // Display the current temperature
        ),
        AppDimensions.sizedBoxH4,
        const WeatherLocation(
          style: HomeStyles
              .weatherDefaultTextStyle, // Display the current location
        ),
        AppDimensions.sizedBoxH4,
        Row(
          children: [
            Text(
              "Wind: ${_weatherData?.currentWeather.windSpeed?.toStringAsFixed(0) ?? "N/A"} m/s", // Display wind speed
              textAlign: TextAlign.center,
              style: HomeStyles.weatherDefaultTextStyle,
            ),
            AppDimensions.sizedBoxW4,
            Text(
              "Humidity: ${_weatherData?.currentWeather.humidity?.toStringAsFixed(0) ?? "N/A"}%", // Display humidity
              textAlign: TextAlign.center,
              style: HomeStyles.weatherDefaultTextStyle,
            )
          ],
        )
      ],
    );
  }
}
