import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';

class WaterIntakeDescription extends StatelessWidget {
  final VoidCallback navigateToResults; // Function to navigate to results page
  final VoidCallback resetCalculator; // Function to reset the calculator

  const WaterIntakeDescription({
    super.key,
    required this.navigateToResults,
    required this.resetCalculator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(24)), // Rounded corners
        ),
        shadows: [
          WaterIntakeCalcStyles.underBoxShadow, // Shadow for depth
        ],
      ),
      child: Column(
        children: [
          const Text(
            WaterIntakeConstants.waterCalDescription, // Description text
            textAlign: TextAlign.center,
            style: WaterIntakeCalcStyles.descriptionText,
          ),
          AppDimensions.sizedBoxH12,
          GestureDetector(
            onTap:
                navigateToResults, // Call function to navigate to results page
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color:
                    const Color(0xFFE6A4B4), // Background color of the button
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)), // Rounded corners
                shadows: const [
                  WaterIntakeCalcStyles.navigateBoxShadow, // Shadow for depth
                ],
              ),
              child: const Text(
                WaterIntakeConstants.getMyGoal, // Button text
                textAlign: TextAlign.center,
                style: WaterIntakeCalcStyles.getGoal,
              ),
            ),
          ),
          AppDimensions.sizedBoxH8,
          GestureDetector(
            onTap: resetCalculator, // Call function to reset the calculator
            child: const Text(
              WaterIntakeConstants.resetCalculation, // Reset button text
              textAlign: TextAlign.center,
              style: WaterIntakeCalcStyles.resetCalc,
            ),
          ),
        ],
      ),
    );
  }
}
