import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';

class EnterYourWeight extends StatelessWidget {
  final TextEditingController weightController; // Controller for weight input

  const EnterYourWeight({
    super.key,
    required this.weightController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          WaterIntakeConstants.enterWeight, // Label for weight input
          textAlign: TextAlign.center,
          style: WaterIntakeCalcStyles.enterYourStyle,
        ),
        AppDimensions.sizedBoxH12,
        Center(
          child: SizedBox(
            width: 250,
            child: TextField(
              controller: weightController, // Text field for entering weight
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor:
                    Color(0xffE6A4B4), // Background color of the text field
              ),
              style: WaterIntakeCalcStyles
                  .inputNumberStyle, // Styling for the input text
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true), // Accept decimal numbers
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d*')), // Allow only numbers and decimals
              ],
            ),
          ),
        ),
      ],
    );
  }
}
