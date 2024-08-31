import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';

class BreakLineWidget extends StatelessWidget {
  const BreakLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDimensions.sizedBoxH10,
        Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xFF795548),
              ),
            ),
          ),
        ),
        AppDimensions.sizedBoxH12,
      ],
    );
  }
}
