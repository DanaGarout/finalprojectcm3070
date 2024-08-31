import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';

class CalculationUnit extends StatelessWidget {
  final String unit; // The unit label (e.g., kg, lb, cm, inch)
  final VoidCallback
      unitConvert; // Function to execute when the unit is selected
  final Color color; // The background color of the unit box

  const CalculationUnit({
    super.key,
    required this.unit,
    required this.color,
    required this.unitConvert,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unitConvert, // Trigger the unit conversion function on tap
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        decoration: ShapeDecoration(
          color: color, // Background color of the unit box
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFEBEBEC),
            ),
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          shadows: const [
            WaterIntakeCalcStyles.boxShadowFirst, // Box shadow for depth
            WaterIntakeCalcStyles.boxShadowSecond,
          ],
        ),
        child: Text(
          unit, // Display the unit label (e.g., kg, lb, cm, inch)
          textAlign: TextAlign.center,
          style: WaterIntakeCalcStyles.unitStyle, // Styling for the unit text
        ),
      ),
    );
  }
}
