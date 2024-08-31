import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';
import 'package:ultratasks/core/utils/constants.dart';

class GenderWidget extends StatelessWidget {
  final VoidCallback male; // Function to call when "Male" is selected
  final VoidCallback female; // Function to call when "Female" is selected
  final Color maleColor; // Background color for "Male" button
  final Color femaleColor; // Background color for "Female" button

  const GenderWidget({
    super.key,
    required this.female,
    required this.male,
    required this.femaleColor,
    required this.maleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: male, // Call function when "Male" is selected
          style: ElevatedButton.styleFrom(
            backgroundColor: maleColor, // Background color for "Male" button
          ),
          child: const Text(
            WaterIntakeConstants.male, // Label for "Male" button
            style: WaterIntakeCalcStyles.unitStyle,
          ),
        ),
        ElevatedButton(
          onPressed: female, // Call function when "Female" is selected
          style: ElevatedButton.styleFrom(
            backgroundColor:
                femaleColor, // Background color for "Female" button
          ),
          child: const Text(
            WaterIntakeConstants.female, // Label for "Female" button
            style: WaterIntakeCalcStyles.unitStyle,
          ),
        ),
      ],
    );
  }
}
