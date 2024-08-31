import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultratasks/core/styles/AppStyles/WeatherStyles/weather_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:weather/weather.dart';

class WeatherByHourWidget extends StatefulWidget {
  const WeatherByHourWidget({super.key});

  @override
  State<WeatherByHourWidget> createState() => _WeatherByHourWidgetState();
}

class _WeatherByHourWidgetState extends State<WeatherByHourWidget> {
  final WeatherFactory _wf = WeatherFactory(
    WeatherConstants.weatherApiKey, // API key for fetching weather data
  );

  Weather? _currentWeather; // Stores the current weather data
  List<Weather>? _hourlyWeather; // Stores the hourly weather data

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get the current location when the widget is initialized
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (kDebugMode) {
        print('Location services are disabled.');
      }
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (kDebugMode) {
          print('Location permissions are denied.');
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (kDebugMode) {
        print('Location permissions are permanently denied.');
      }
      return;
    }

    // When permissions are granted, get the position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _fetchWeather(position.latitude,
          position.longitude); // Fetch weather using the position
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

  Future<void> _fetchWeather(double lat, double lon) async {
    try {
      Weather currentWeather = await _wf.currentWeatherByLocation(lat, lon);
      List<Weather> hourlyWeather =
          await _wf.fiveDayForecastByLocation(lat, lon);
      setState(() {
        _currentWeather =
            currentWeather; // Update the state with the current weather
        _hourlyWeather = _generateConsecutiveHourlyWeather(
            hourlyWeather); // Generate hourly weather data
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather: $e');
      }
    }
  }

  // Generate 24 consecutive hourly weather entries
  List<Weather> _generateConsecutiveHourlyWeather(List<Weather> weatherList) {
    List<Weather> hourlyList = [];
    DateTime currentTime = DateTime.now();

    for (int i = 0; i < 24; i++) {
      DateTime hour = currentTime.add(Duration(hours: i));
      // Find the closest weather data for this hour
      Weather? closestWeather = _getClosestWeatherForHour(weatherList, hour);
      if (closestWeather != null) {
        hourlyList
            .add(closestWeather); // Add the closest weather data to the list
      }
    }

    return hourlyList;
  }

  // Find the closest weather data for a specific hour
  Weather? _getClosestWeatherForHour(List<Weather> weatherList, DateTime hour) {
    Weather? closestWeather;
    int minDifference = 99999; // Arbitrarily large number

    for (Weather weather in weatherList) {
      int difference = (weather.date!.difference(hour).inMinutes).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestWeather = weather; // Update the closest weather data
      }
    }

    return closestWeather;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentWeather == null || _hourlyWeather == null) {
      return const Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      );
    }
    return _hourlyWeatherList(); // Display the hourly weather list
  }

  Widget _hourlyWeatherList() {
    List<String> timeIntervals = [
      "12:00 AM - 1:00 AM",
      "1:00 AM - 2:00 AM",
      "2:00 AM - 3:00 AM",
      "3:00 AM - 4:00 AM",
      "4:00 AM - 5:00 AM",
      "5:00 AM - 6:00 AM",
      "6:00 AM - 7:00 AM",
      "7:00 AM - 8:00 AM",
      "8:00 AM - 9:00 AM",
      "9:00 AM - 10:00 AM",
      "10:00 AM - 11:00 AM",
      "11:00 AM - 12:00 PM",
      "12:00 PM - 1:00 PM",
      "1:00 PM - 2:00 PM",
      "2:00 PM - 3:00 PM",
      "3:00 PM - 4:00 PM",
      "4:00 PM - 5:00 PM",
      "5:00 PM - 6:00 PM",
      "6:00 PM - 7:00 PM",
      "7:00 PM - 8:00 PM",
      "8:00 PM - 9:00 PM",
      "9:00 PM - 10:00 PM",
      "10:00 PM - 11:00 PM",
      "11:00 PM - 12:00 AM"
    ];

    return SizedBox(
      height:
          MediaQuery.sizeOf(context).height * 1, // Adjust the height as needed
      child: ListView.builder(
        itemCount: _hourlyWeather?.length ?? 0,
        itemBuilder: (context, index) {
          Weather weather = _hourlyWeather![index];
          String timeInterval =
              timeIntervals[index % 24]; // Loop through intervals
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: ShapeDecoration(
                  color: Colors.black.withOpacity(0.6000000238418579),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeInterval, // Display the time interval
                          style: WeatherStyles.hoursStyle,
                        ),
                        Row(
                          children: [
                            Image.network(
                              "http://openweathermap.org/img/wn/${_currentWeather?.weatherIcon}@4x.png", // Display the weather icon
                              width: 24,
                              height: 24,
                            ),
                            Text(
                              weather.weatherDescription ??
                                  "", // Display the weather description
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      '${weather.temperature?.celsius?.toStringAsFixed(0)}°C', // Display the temperature
                      style: WeatherStyles.degreesStyle,
                    ),
                  ],
                ),
              ),
              AppDimensions.sizedBoxH12,
            ],
          );
        },
      ),
    );
  }
}
