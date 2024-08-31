import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ultratasks/core/styles/app_color.dart';
import 'package:ultratasks/core/firebase/services/database_service.dart';
import 'package:ultratasks/core/utils/constants.dart';
import 'package:ultratasks/features/Auth/OTP/otp_screen.dart';
import 'package:ultratasks/features/Auth/SignIn/pages/sign_in_intro_page.dart';
import 'package:ultratasks/core/custom_widgets/button_custom_widget.dart';
import 'package:ultratasks/core/custom_widgets/sign_in_custom_textfield.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_in_logo_title.dart';
import 'package:ultratasks/features/Auth/SignIn/widgets/sign_up_if_account.dart';
import 'package:ultratasks/core/firebase/services/firebase_auth_services.dart';
import 'package:ultratasks/core/firebase/services/firestore_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthServices auth = FirebaseAuthServices();
  final FirestoreService firestoreService = FirestoreService();

  // Controllers for managing text inputs in the sign-up form
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController createPasswordController =
      TextEditingController();
  final TextEditingController recreatePasswordController =
      TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  // Variables to store error messages for form validation
  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? rePasswordError;
  String? dateofBirthError;

  @override
  void dispose() {
    // Dispose of controllers when the widget is removed from the tree
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    createPasswordController.dispose();
    recreatePasswordController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  // Validate user input fields and update error variables
  void _validateInputs() {
    setState(() {
      firstNameError = firstNameController.text.isEmpty
          ? AuthConstants.pleaseFirstName
          : null;
      lastNameError =
          lastNameController.text.isEmpty ? AuthConstants.pleaseLastName : null;
      emailError =
          emailController.text.isEmpty ? AuthConstants.pleaseEmail : null;
      phoneError =
          phoneController.text.isEmpty ? AuthConstants.pleasePhone : null;
      passwordError = createPasswordController.text.isEmpty
          ? AuthConstants.pleasePassword
          : null;
      rePasswordError =
          createPasswordController.text != recreatePasswordController.text
              ? AuthConstants.passwordNotmatch
              : null;
      dateofBirthError = birthDateController.text != birthDateController.text
          ? AuthConstants.pleaseDate
          : null;
    });
  }

  DateTime? selectedDate;

  // Show a date picker dialog for selecting the user's date of birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = DateFormat('d MMMM y').format(picked);
      });
    }
  }

  // Handle the sign-up process
  void _signUp() async {
    _validateInputs();

    // Proceed if all inputs are valid
    if (firstNameError == null &&
        lastNameError == null &&
        emailError == null &&
        phoneError == null &&
        passwordError == null &&
        rePasswordError == null &&
        dateofBirthError == null) {
      String email = emailController.text;
      String password = createPasswordController.text;
      String firstname = firstNameController.text;
      String lastname = lastNameController.text;
      String phone = phoneController.text;
      String date = birthDateController.text;

      // Attempt to sign up the user with email and password
      User? user = await auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        // Create a new user document in Firestore with the provided details
        await firestoreService.createUserDocument(
            firstname, lastname, phone, date, email);

        // Initialize the user's task collection reference in the database
        DatabaseService().initializeUserTasks();

        // Start the phone number verification process
        FirebaseAuth.instance.verifyPhoneNumber(
          timeout: const Duration(minutes: 2),
          phoneNumber: phoneController.text,
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: (error) {
            if (kDebugMode) {
              print('Verification has failed');
            }
          },
          codeSent: (verificationId, forceResendingToken) {
            // Navigate to the OTP screen for the user to enter the verification code
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        verificationId: verificationId,
                      )),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {
            if (kDebugMode) {
              print('Timeout has occurred');
            }
          },
        );
      } else {
        if (kDebugMode) {
          print('Error happening');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.beige,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        backgroundColor: AppColor.beige,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SignInLogoTitle(),
            SignInCustomTextField(
              labelText: AuthConstants.firstName,
              hintText: AuthConstants.enterFirstName,
              textInputType: TextInputType.name,
              controller: firstNameController,
              errorText: firstNameError,
            ),
            SignInCustomTextField(
              labelText: AuthConstants.lastName,
              hintText: AuthConstants.enterLastName,
              textInputType: TextInputType.name,
              controller: lastNameController,
              errorText: lastNameError,
            ),
            SignInCustomTextField(
              labelText: AuthConstants.emailAddress,
              hintText: AuthConstants.emailExample,
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              errorText: emailError,
            ),
            SignInCustomTextField(
              labelText: AuthConstants.phoneNumber,
              hintText: AuthConstants.enterPhone,
              controller: phoneController,
              textInputType: TextInputType.phone,
              errorText: phoneError,
            ),
            SignInCustomTextField(
              labelText: AuthConstants.dateOfBirth,
              hintText: AuthConstants.enterDate,
              controller: birthDateController,
              errorText: dateofBirthError,
              onTap: () => _selectDate(context),
            ),
            SignInCustomTextField(
              labelText: AuthConstants.createPassword,
              hintText: '',
              controller: createPasswordController,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              errorText: passwordError,
            ),
            SignInCustomTextField(
              labelText: AuthConstants.reCreatePassword,
              hintText: '',
              controller: recreatePasswordController,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              errorText: rePasswordError,
            ),
            const SizedBox(height: 10),
            ButtonCustomWidget(
              text: AuthConstants.signUp,
              buttonColor: AppColor.pink,
              onPressed: _signUp,
            ),
            const SizedBox(height: 10),
            SignUpIfNoAccount(
              firstLine: AuthConstants.accountAlreadyLine,
              secondLine: AuthConstants.login,
              onPressed: () {
                // Navigate to the sign-in introduction page
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const SignInIntroPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
