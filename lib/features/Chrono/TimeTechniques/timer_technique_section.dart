import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Chrono/TimeTechniques/timer_custom_page.dart';
import 'package:ultratasks/features/Chrono/TimeTechniques/timer_description_custom_page.dart';

class TimerTechniqueSection extends StatelessWidget {
  const TimerTechniqueSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to Pomodoro Technique description page
    void pomodoroPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimerDescriptionCustomPage(
            descriptionParagraph: ChronoConstants.pomodoroTechniqueDescription,
            descriptionTitle: ChronoConstants.pomodoroTech,
            techniqueName: ChronoConstants.pomodoroTechnique,
            onPressed: () {
              // Navigate to the Pomodoro timer page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const TimerCustomPage(
                    timerTitle: ChronoConstants.pomodoroTech,
                    workMinutes: 25,
                    breakMinutes: 5,
                    isPomodoro: true,
                  );
                },
              ));
            },
          ),
        ),
      );
    }

    // Navigate to 52/17 Rule description page
    void fiftyTwoSeventeenPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimerDescriptionCustomPage(
            techniqueName: ChronoConstants.fiftyTwoSeventeen,
            descriptionParagraph: ChronoConstants.fiftyTwoSeventeenDescription,
            descriptionTitle: ChronoConstants.fiftyTwoTechinue,
            onPressed: () {
              // Navigate to the 52/17 timer page
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const TimerCustomPage(
                    timerTitle: ChronoConstants.fiftyTwoTechinue,
                    workMinutes: 52,
                    breakMinutes: 17,
                    isPomodoro: false,
                  );
                },
              ));
            },
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 15,
        bottom: 22,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF3D1A0E), Color(0xFF795548)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          // Section title for Timer Techniques
          const Text(
            ChronoConstants.timerTechniques,
            textAlign: TextAlign.center,
            style: ChronoStyles.timerTechniqueSectionTitleStyle,
          ),
          AppDimensions.sizedBoxH6,
          // Row containing the technique buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Button for 52/17 Rule
              GestureDetector(
                onTap: fiftyTwoSeventeenPage,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    ChronoConstants.fifty17,
                    textAlign: TextAlign.center,
                    style: ChronoStyles.techniqueNameStyle,
                  ),
                ),
              ),
              // Button for Pomodoro Technique
              GestureDetector(
                onTap: pomodoroPage,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    ChronoConstants.pomodoro,
                    textAlign: TextAlign.center,
                    style: ChronoStyles.techniqueNameStyle,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
