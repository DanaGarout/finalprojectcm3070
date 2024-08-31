import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';

class WaterResultDescription extends StatelessWidget {
  final String result; // The calculated water intake result
  final String waterCups; // The number of cups required

  const WaterResultDescription({
    super.key,
    required this.result,
    required this.waterCups,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      child: Text(
        "You need to drink $result l of water per day.\nThat’s about $waterCups cups of water", // Display the result and number of cups
        textAlign: TextAlign.center,
        style: WaterIntakeCalcStyles.intakeParagraphStyle,
      ),
    );
  }
}
