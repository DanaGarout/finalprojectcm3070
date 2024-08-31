import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/ProfileStyles/profile_styles.dart';
import 'package:ultratasks/core/styles/app_dimensions.dart';
import 'package:ultratasks/core/utils/assets_path.dart';
import 'package:ultratasks/core/firebase/services/firestore_service.dart';

class UsernameImageWidget extends StatelessWidget {
  const UsernameImageWidget({super.key});

  Future<Map<String, dynamic>?> _getNames() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService
        .getUserData(); // Fetch user data from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getNames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Error loading names')); // Handle errors
        } else {
          String firstname = snapshot.data?['firstname'] ??
              'User'; // Get first name or use default
          String lastname = snapshot.data?['lastname'] ??
              'Name'; // Get last name or use default

          return Column(
            children: [
              Image.asset(
                ProfileAssetsPath.profilePic,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    firstname,
                    style: ProfileStyles.profileUsernameTextStyle,
                  ),
                  AppDimensions.sizedBoxW4,
                  Text(
                    lastname,
                    style: ProfileStyles.profileUsernameTextStyle,
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
