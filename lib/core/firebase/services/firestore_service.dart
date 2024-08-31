import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to create a new user document in Firestore
  Future<void> createUserDocument(String firstName, String lastName,
      String phone, String date, String email) async {
    // Get the currently signed-in user
    User? user = _auth.currentUser;

    if (user != null) {
      // Reference to the user's document in the 'users' collection
      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);

      // Check if the document already exists
      DocumentSnapshot docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        // If it doesn't exist, create a new document with the provided user data
        await userDoc.set({
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'phone': phone,
          'date': date,
        });
      }
    }
  }

  // Method to retrieve user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    // Get the currently signed-in user
    User? user = _auth.currentUser;
    if (user != null) {
      // Retrieve the user's document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      // Return the user data as a Map
      return userDoc.data() as Map<String, dynamic>?;
    }
    // Return null if no user is signed in or the document doesn't exist
    return null;
  }
}
