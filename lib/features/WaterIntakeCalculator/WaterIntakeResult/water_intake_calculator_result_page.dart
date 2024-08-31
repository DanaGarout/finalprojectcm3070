import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/water_intake_calculator_page.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeResult/water_intake_result.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeResult/water_result_description.dart';
import 'package:ultratasks/features/ultra_task.dart';

class WaterIntakeCalculatorResultPage extends StatefulWidget {
  const WaterIntakeCalculatorResultPage({super.key});

  @override
  State<WaterIntakeCalculatorResultPage> createState() =>
      _WaterIntakeCalculatorResultPageState();
}

class _WaterIntakeCalculatorResultPageState
    extends State<WaterIntakeCalculatorResultPage> {
  late List<bool> _cupsDrunk; // Track which cups of water have been consumed
  String? _result; // The calculated water intake result
  String? _cupsResults; // The number of cups required
  bool _loading = true; // Loading state indicator

  @override
  void initState() {
    super.initState();
    _loadWaterIntakeData(); // Load saved water intake data when the page initializes
  }

  // Load user water intake data from the database
  Future<void> _loadWaterIntakeData() async {
    final data = await DatabaseService().getUserWaterIntakeData();
    if (data != null) {
      setState(() {
        _result = data[WaterIntakeConstants.waterIntake]
            .toStringAsFixed(2); // Format water intake result
        _cupsResults = data[WaterIntakeConstants.waterCups].toString();
        int cups = int.parse(_cupsResults!);
        _loading = true;
        _loadCupsState(cups); // Load the state of the cups (checked/unchecked)
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  // Load the state of the cups (checked/unchecked) from the database
  Future<void> _loadCupsState(int numberOfCups) async {
    _cupsDrunk = await DatabaseService().getCupsState(numberOfCups);
    setState(() {
      _loading = false;
    });
  }

  // Update the state when a cup checkbox is checked/unchecked
  void _onCupChecked(int index, bool? value) {
    setState(() {
      _cupsDrunk[index] = value ?? false;
    });
    DatabaseService().saveCupsState(_cupsDrunk); // Save the updated state
  }

  // Navigate to the calculator page to recalculate
  void navigateToCalculator() {
    resetFields(); // Reset the fields before navigating back
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const WaterIntakeCalculatorPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  // Return to the home page
  void returnToHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UltraTask(),
      ),
    );
  }

  // Reset all fields and delete saved data from the database
  void resetFields() {
    DatabaseService().deleteUserWaterIntakeData();
    setState(() {
      _result = '';
      _cupsResults = '';
      _cupsDrunk = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
          child:
              CircularProgressIndicator()); // Show loading spinner if data is still being loaded
    }

    return CustomScaffold(
      automaticallyImplyLeading: true,
      appBarColor: const Color(0xffE6A4B4),
      backgroundColor: const Color(0xffE6A4B4),
      pageTitle: '',
      body: SingleChildScrollView(
        child: Center(
          child: _result == null || _cupsResults == null
              ? const Text(WaterIntakeConstants
                  .noDataAvailable) // Show message if no data is available
              : Column(
                  children: [
                    const Text(
                      WaterIntakeConstants
                          .dailyIntake, // Title of the results page
                      textAlign: TextAlign.center,
                      style: WaterIntakeCalcStyles.dailyIntakeTitle,
                    ),
                    AppDimensions.sizedBoxH40,
                    WaterIntakeResult(
                      result: _result!, // Display the calculated water intake
                    ),
                    AppDimensions.sizedBoxH20,
                    _buildCupsTracker(), // Build the cups tracker widget
                    AppDimensions.sizedBoxH40,
                    WaterResultDescription(
                      result: _result!,
                      waterCups: _cupsResults!,
                    ),
                    AppDimensions.sizedBoxH12,
                    ButtonCustomWidget(
                      text: WaterIntakeConstants.calculator,
                      onPressed:
                          navigateToCalculator, // Navigate back to calculator
                      buttonColor: AppColor.brown,
                    ),
                    AppDimensions.sizedBoxH12,
                    GestureDetector(
                      onTap: returnToHomePage, // Navigate to home page
                      child: const Text(
                        WaterIntakeConstants.backToHomePage,
                        textAlign: TextAlign.center,
                        style: WaterIntakeCalcStyles.resetCalc,
                      ),
                    ),
                    AppDimensions.sizedBoxH12,
                  ],
                ),
        ),
      ),
    );
  }

  // Build the list of cup checkboxes
  Widget _buildCupsTracker() {
    return Column(
      children: List.generate(_cupsDrunk.length, (index) {
        return CheckboxListTile(
          title: Row(
            children: [
              Image.asset(
                WaterIntakeAssetsPath.waterCup, // Image of a water cup
              ),
              AppDimensions.sizedBoxW4,
              Text(
                'Cup ${index + 1}', // Label for each cup
                style: WaterIntakeCalcStyles.intakeParagraphStyle,
              ),
            ],
          ),
          value: _cupsDrunk[index], // Whether the cup is drunk or not
          onChanged: (bool? value) {
            _onCupChecked(
                index, value); // Update and save state when checkbox is clicked
          },
        );
      }),
    );
  }
}
