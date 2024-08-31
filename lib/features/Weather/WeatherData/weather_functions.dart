import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Weather/WeatherData/weather_data.dart';
import 'package:weather/weather.dart';

class WeatherService {
  final WeatherFactory _weatherFactory = WeatherFactory(
    WeatherConstants.weatherApiKey, // API key for fetching weather data
  );

  // Retrieves the user's current location
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Location services are disabled.');
      }
      return null;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('Location permissions are denied.');
        }
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print('Location permissions are permanently denied.');
      }
      return null;
    }

    // Get the current location if permissions are granted
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position; // Return the current position
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      return null;
    }
  }

  // Fetches the weather data based on the provided latitude and longitude
  Future<WeatherData?> fetchWeather(double lat, double lon) async {
    try {
      Weather currentWeather = await _weatherFactory.currentWeatherByLocation(
          lat, lon); // Fetch current weather
      List<Weather> hourlyWeather = await _weatherFactory
          .fiveDayForecastByLocation(lat, lon); // Fetch hourly weather data
      return WeatherData(
        currentWeather: currentWeather,
        hourlyWeather: hourlyWeather,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather: $e');
      }
      return null;
    }
  }
}
