import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultratasks/core/custom_widgets/subtitle_custom_widget.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/water_intake_calculator_page.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeResult/water_intake_calculator_result_page.dart';

class WaterIntakeCalculatorSection extends StatelessWidget {
  const WaterIntakeCalculatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the appropriate page based on the availability of saved water intake data
    void navigateToWaterIntakeCalculator() async {
      final data = await DatabaseService().getUserWaterIntakeData();
      if (data != null) {
        // Navigate directly to results page if data exists
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WaterIntakeCalculatorResultPage(),
          ),
        );
      } else {
        // Navigate to calculator page if no data exists
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WaterIntakeCalculatorPage(),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: navigateToWaterIntakeCalculator, // Trigger navigation on tap
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitleWidget(
            subtitle: WaterIntakeConstants.waterIntakeCal, // Section title
          ),
          AppDimensions.sizedBoxH8,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(1.00, 0.06),
                end: Alignment(-1, -0.06),
                colors: [
                  Color(0xFF0085E6),
                  Color(0xFF004A80)
                ], // Gradient background
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 175,
                  child: Text(
                    WaterIntakeConstants.clickForCalc, // Call to action text
                    style: WaterIntakeCalcStyles.waterIntakeSectionTextStyle,
                  ),
                ),
                SvgPicture.asset(
                  WaterIntakeAssetsPath.water, // Water icon
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
