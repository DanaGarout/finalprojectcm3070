import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';

class WorldClockCountry extends StatelessWidget {
  final String countryFlag; // Path to the country's flag icon
  final String countryTime; // Formatted time of the country
  final String countryName; // Name of the country/city
  const WorldClockCountry({
    super.key,
    required this.countryFlag,
    required this.countryName,
    required this.countryTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Display the country's flag
        SvgPicture.asset(
          countryFlag,
          package: 'country_icons',
          width: 30,
          height: 30,
        ),
        AppDimensions.sizedBoxW8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the time and country name
            Text(
              countryTime,
              textAlign: TextAlign.center,
              style: ChronoStyles.worldClockSectionTimeStyle,
            ),
            Text(
              countryName,
              textAlign: TextAlign.center,
              style: ChronoStyles.worldClockSectionLocationStyle,
            ),
            AppDimensions.sizedBoxH4,
          ],
        ),
      ],
    );
  }
}
