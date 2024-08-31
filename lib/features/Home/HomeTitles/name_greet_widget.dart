import 'package:flutter/material.dart';
import 'package:ultratasks/core/styles/AppStyles/HomeStyles/home_styles.dart';
import 'package:ultratasks/core/firebase/services/firestore_service.dart';
import 'package:ultratasks/core/utils/constants.dart';

class NameGreetWidget extends StatelessWidget {
  const NameGreetWidget({
    super.key,
  });

  Future<Map<String, dynamic>?> _getName() async {
    FirestoreService firestoreService = FirestoreService();
    return await firestoreService
        .getUserData(); // Fetch user data from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _getName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (snapshot.hasError) {
          return const Center(
              child: Text(HomeConstants
                  .userNameError)); // Show error message if something goes wrong
        } else {
          String firstname = snapshot.data?['firstname'] ?? '';
          return Text(
            'Hello $firstname!',
            style: HomeStyles
                .nameGreetTitleStyle, // Greet the user with their first name
          );
        }
      },
    );
  }
}
