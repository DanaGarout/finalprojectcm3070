import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/ChronoStyles/chrono_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';

class TimerDescriptionCustomPage extends StatelessWidget {
  final String techniqueName;
  final String descriptionTitle;
  final String descriptionParagraph;
  final VoidCallback onPressed;

  const TimerDescriptionCustomPage({
    super.key,
    required this.descriptionParagraph,
    required this.descriptionTitle,
    required this.techniqueName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: true,
      pageTitle: techniqueName,
      backgroundColor: const Color(0xFF1A1A1A),
      appBarColor: const Color(0xFF1A1A1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF1A1A1A), Color(0xFF808080)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              // Display the technique name at the top of the page
              Text(
                techniqueName,
                textAlign: TextAlign.center,
                style: ChronoStyles.techniqueDescStyle,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 44,
                    left: 47,
                    right: 46,
                    bottom: 60,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Display the description title of the technique
                      Text(
                        descriptionTitle,
                        style: ChronoStyles.techDescTitleStyle,
                      ),
                      AppDimensions.sizedBoxH6,
                      // Display the description paragraph of the technique
                      Text(
                        descriptionParagraph,
                        textAlign: TextAlign.center,
                        style: ChronoStyles.techDescParaStyle,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      // Button to start tracking the technique
                      GestureDetector(
                        onTap: onPressed,
                        child: Container(
                          width: 271,
                          height: 56,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE6A4B4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            shadows: const [
                              ChronoStyles.techDescBoxShadow,
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Text label for the start tracking button
                              const Text(
                                'Start Tracking',
                                style: ChronoStyles.startTrackStyle,
                              ),
                              const SizedBox(width: 10),
                              // Icon for the start tracking button
                              SvgPicture.asset(
                                ChronoAssetsPath.timerIcon,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
