import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/subtitle_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/WeatherStyles/weather_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Weather/WeatherHomeSection/current_weather_widget.dart';
import 'package:ultratasks/features/Weather/WeatherHomeSection/weather_icon_state.dart';
import 'package:ultratasks/features/Weather/WeatherDisplayPage/weather_display_page.dart';

class WeatherSectionWidget extends StatelessWidget {
  const WeatherSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to navigate to the WeatherDisplayPage
    void navigationToWeatherPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WeatherDisplayPage(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitleWidget(
          subtitle: WeatherConstants.weather, // Section title
        ),
        AppDimensions.sizedBoxH8,
        GestureDetector(
          onTap:
              navigationToWeatherPage, // Navigate when the container is tapped
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-0.01, -1.00),
                end: Alignment(0.01, 1),
                colors: [
                  AppColor.blueLinear1,
                  AppColor.blueLinear2,
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: const [
                WeatherStyles.weatherSectionBoxShadow,
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentWeatherWidget(), // Widget to display current weather details
                WeatherIconState(), // Widget to display the weather icon and state
              ],
            ),
          ),
        )
      ],
    );
  }
}
