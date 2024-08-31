import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';

class WaterIntakeResult extends StatelessWidget {
  final String result; // The calculated water intake result

  const WaterIntakeResult({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: result, // Display the water intake amount
            style: WaterIntakeCalcStyles.intakeNumber,
          ),
          const TextSpan(
            text: ' litres', // Display the unit "litres"
            style: WaterIntakeCalcStyles.mlStyle,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
