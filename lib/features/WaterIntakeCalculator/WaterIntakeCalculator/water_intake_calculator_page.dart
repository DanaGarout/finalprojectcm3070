import 'package:flutter/material.dart';
import 'package:ultratasks/core/custom_widgets/custom_scaffold.dart';
import 'package:ultratasks/core/styles/AppStyles/WaterIntakeCalculatorStyles/water_intake_calc_styles.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/calculation_unit.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/enter_your_height.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/enter_your_weight.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/gender_widget.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeCalculator/water_intake_description.dart';
import 'package:ultratasks/features/WaterIntakeCalculator/WaterIntakeResult/water_intake_calculator_result_page.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';

class WaterIntakeCalculatorPage extends StatefulWidget {
  const WaterIntakeCalculatorPage({super.key});

  @override
  State<WaterIntakeCalculatorPage> createState() =>
      _WaterIntakeCalculatorPageState();
}

class _WaterIntakeCalculatorPageState extends State<WaterIntakeCalculatorPage> {
  final TextEditingController weightController =
      TextEditingController(); // Controller for weight input
  final TextEditingController heightController =
      TextEditingController(); // Controller for height input
  String gender = WaterIntakeConstants.male; // Default gender
  String weightUnit = WaterIntakeConstants.kg; // Default weight unit
  String heightUnit = WaterIntakeConstants.cm; // Default height unit
  String result = ''; // Calculated water intake result
  String cupsResults = ''; // Calculated number of cups
  bool _loading = true; // Loading state indicator

  @override
  void initState() {
    super.initState();
    _loadWaterIntakeData(); // Load any previously saved water intake data when the page initializes
  }

  // Load user water intake data from the database
  Future<void> _loadWaterIntakeData() async {
    final data = await DatabaseService().getUserWaterIntakeData();
    if (data != null) {
      setState(() {
        weightController.text = data[WaterIntakeConstants.weight].toString();
        heightController.text = data[WaterIntakeConstants.height].toString();
        result = data[WaterIntakeConstants.waterIntake].toString();
        cupsResults = data[WaterIntakeConstants.waterCups].toString();
        gender = data[WaterIntakeConstants.gender] ?? WaterIntakeConstants.male;
        weightUnit =
            data[WaterIntakeConstants.weightUnit] ?? WaterIntakeConstants.kg;
        heightUnit =
            data[WaterIntakeConstants.heightUnit] ?? WaterIntakeConstants.cm;
        _loading = false;
      });
      _navigateToResults(); // Navigate to the results page if data is loaded
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  // Calculate the daily water intake based on user's input
  void calculateWaterIntake() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    if (weightUnit == WaterIntakeConstants.lb) {
      weight = weight * 0.453592; // Convert pounds to kilograms
    }
    if (heightUnit == WaterIntakeConstants.inch) {
      height = height * 2.54; // Convert inches to centimeters
    }
    double waterIntake = weight * 0.033; // Basic water intake formula

    if (gender == WaterIntakeConstants.female) {
      waterIntake *= 0.95; // Adjust for female gender
    } else if (height > 180) {
      waterIntake *= 1.1; // Adjust for height over 180 cm
    }
    int cups = (waterIntake / 0.24).round(); // Convert to cups (240ml per cup)

    setState(() {
      result = waterIntake
          .toStringAsFixed(2); // Format the result to 2 decimal places
      cupsResults = '$cups'; // Store the number of cups
    });

    // Save the calculated data to Firebase
    DatabaseService().saveUserWaterIntakeData(
      height: height,
      weight: weight,
      gender: gender,
      weightUnit: weightUnit,
      heightUnit: heightUnit,
      waterIntake: waterIntake,
      waterCups: cups,
    );

    _navigateToResults(); // Navigate to the results page
  }

  // Navigate to the results page
  void _navigateToResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WaterIntakeCalculatorResultPage(),
      ),
    );
  }

  // Reset all fields and delete saved data from the database
  void resetFields() {
    weightController.clear();
    heightController.clear();
    setState(() {
      result = '';
      gender = WaterIntakeConstants.male;
      weightUnit = WaterIntakeConstants.kg;
      heightUnit = WaterIntakeConstants.cm;
    });

    // Optionally, delete the saved data from Firebase
    DatabaseService().deleteUserWaterIntakeData();
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
      pageTitle: WaterIntakeConstants.waterIntakeCal,
      titleStyle: WaterIntakeCalcStyles.waterIntakePageTitle,
      backgroundColor: const Color(0xffE6A4B4),
      appBarColor: const Color(0xffE6A4B4),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      WaterIntakeAssetsPath.waterCup, // Water cup image
                    ),
                  ),
                  AppDimensions.sizedBoxH6,
                  GenderWidget(
                    female: () {
                      setState(() {
                        gender =
                            WaterIntakeConstants.female; // Set gender to female
                      });
                    },
                    male: () {
                      setState(() {
                        gender =
                            WaterIntakeConstants.male; // Set gender to male
                      });
                    },
                    femaleColor: gender == WaterIntakeConstants.female
                        ? Colors.pink
                        : Colors.white, // Highlight selected gender
                    maleColor: gender == WaterIntakeConstants.male
                        ? AppColor.brandBlue
                        : Colors.white,
                  ),
                  AppDimensions.sizedBoxH12,
                  EnterYourWeight(
                    weightController:
                        weightController, // Input field for weight
                  ),
                  AppDimensions.sizedBoxH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CalculationUnit(
                        color: weightUnit == WaterIntakeConstants.lb
                            ? AppColor.brandBlue
                            : Colors.white, // Highlight selected weight unit
                        unit: WaterIntakeConstants.lb,
                        unitConvert: () {
                          setState(() {
                            weightUnit = WaterIntakeConstants
                                .lb; // Set weight unit to pounds
                          });
                        },
                      ),
                      CalculationUnit(
                        unit: WaterIntakeConstants.kg,
                        color: weightUnit == WaterIntakeConstants.kg
                            ? AppColor.brandBlue
                            : Colors.white, // Highlight selected weight unit
                        unitConvert: () {
                          setState(() {
                            weightUnit = WaterIntakeConstants
                                .kg; // Set weight unit to kilograms
                          });
                        },
                      ),
                    ],
                  ),
                  AppDimensions.sizedBoxH12,
                  EnterYourHeight(
                    heightController:
                        heightController, // Input field for height
                  ),
                  AppDimensions.sizedBoxH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CalculationUnit(
                        unit: WaterIntakeConstants.cm,
                        color: heightUnit == WaterIntakeConstants.cm
                            ? AppColor.brandBlue
                            : Colors.white, // Highlight selected height unit
                        unitConvert: () {
                          setState(() {
                            heightUnit = WaterIntakeConstants
                                .cm; // Set height unit to centimeters
                          });
                        },
                      ),
                      CalculationUnit(
                        unit: WaterIntakeConstants.inch,
                        color: heightUnit == WaterIntakeConstants.inch
                            ? AppColor.brandBlue
                            : Colors.white, // Highlight selected height unit
                        unitConvert: () {
                          setState(() {
                            heightUnit = WaterIntakeConstants
                                .inch; // Set height unit to inches
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              AppDimensions.sizedBoxH36,
              WaterIntakeDescription(
                navigateToResults:
                    calculateWaterIntake, // Trigger calculation and navigation to results
                resetCalculator: resetFields, // Reset all fields
              ),
            ],
          ),
        ),
      ),
    );
  }
}
