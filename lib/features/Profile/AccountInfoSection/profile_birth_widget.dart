import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/ProfileStyles/profile_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/firebase/services/firestore_service.dart';
import 'package:ultratasks/core/utils/constants.dart';

class ProfileBirthWidget extends StatelessWidget {
  const ProfileBirthWidget({super.key});

  Future<Map<String, dynamic>?> _getDate() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService
        .getUserData(); // Fetch user data from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: _getDate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading birth date')); // Handle errors
          } else {
            String date = snapshot.data?['date'] ??
                'date'; // Get birth date or use default
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AuthConstants.dateOfBirth,
                      style: ProfileStyles.infoNameTextStyle,
                    ),
                    Text(
                      date,
                      style: ProfileStyles.infoTextStyle,
                    ),
                  ],
                ),
                AppDimensions.sizedBoxH16,
              ],
            );
          }
        });
  }
}
