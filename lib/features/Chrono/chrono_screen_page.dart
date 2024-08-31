import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Chrono/TimeTechniques/timer_technique_section.dart';
import 'package:ultratasks/features/Chrono/WorldClock/world_clock_section.dart';

class ChronoScreenPage extends StatelessWidget {
  const ChronoScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      pageTitle: ChronoConstants.chrono,
      backgroundColor: AppColor.grey01,
      appBarColor: AppColor.grey01,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Display the clock image at the top of the screen
              Image.asset(
                ChronoAssetsPath.clockImage,
              ),
              // Add vertical space of 20 pixels
              AppDimensions.sizedBoxH20,
              const SizedBox(
                // Display a description of the Chrono feature
                child: Text(
                  ChronoConstants.chronoDescription,
                  textAlign: TextAlign.center,
                  style: ChronoStyles.chronoDescriptionParagraphStyle,
                ),
              ),
              // Add vertical space of 12 pixels
              AppDimensions.sizedBoxH12,
              // Display the World Clock section
              const WorldClockSection(),
              // Add vertical space of 16 pixels
              AppDimensions.sizedBoxH16,
              // Display the Timer Technique section
              const TimerTechniqueSection(),
            ],
          ),
        ),
      ),
    );
  }
}
