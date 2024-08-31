import 'package:weather/weather.dart';

class WeatherData {
  final Weather currentWeather; // Holds the current weather data
  final List<Weather> hourlyWeather; // Holds the hourly weather data

  WeatherData({
    required this.currentWeather,
    required this.hourlyWeather,
  });
}
