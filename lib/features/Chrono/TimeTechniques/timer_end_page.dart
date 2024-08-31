import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';

class TimerEndPage extends StatelessWidget {
  final String timerTitle;
  const TimerEndPage({super.key, required this.timerTitle});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      appBarColor: const Color(0xFF1B1B1B),
      backgroundColor: const Color(0xFF1B1B1B),
      pageTitle: '',
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF1B1B1B), Color(0xFF818181)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              // Display the title of the completed timer
              Text(
                timerTitle,
                textAlign: TextAlign.center,
                style: ChronoStyles.timerEndPageTitleStyle,
              ),
              AppDimensions.sizedBoxH12,
              // Display the Bravo image
              Image.asset(
                ChronoAssetsPath.bravoImage,
              ),
              AppDimensions.sizedBoxH20,
              // Display a message to the user indicating the end of the technique
              const Text(
                ChronoConstants.techniqueEndMessage,
                textAlign: TextAlign.center,
                style: ChronoStyles.goodJobStyle,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              // Button to navigate back to the task page
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFFE6A4B4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  shadows: const [
                    ChronoStyles.timerEndPageBoxShadow,
                  ],
                ),
                child: const Text(
                  ChronoConstants.backToTask,
                  style: ChronoStyles.backToTaskStyle,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
