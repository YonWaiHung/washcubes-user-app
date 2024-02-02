import 'package:device_run_test/src/constants/image_strings.dart';
import 'package:device_run_test/src/utilities/theme/widget_themes/outlinedbutton_theme.dart';
import 'package:device_run_test/src/utilities/theme/widget_themes/textfield_theme.dart';
import 'package:flutter/material.dart';
import 'package:device_run_test/src/features/authentication/screens/userverification/OTPVerifyPage.dart';
import 'package:device_run_test/src/features/authentication/screens/home/HomePage.dart';
import 'package:device_run_test/src/constants/colors.dart';
import 'package:device_run_test/src/constants/sizes.dart';
import 'package:flutter/services.dart';
import 'package:device_run_test/config.dart';
import 'package:http/http.dart' as http;
import 'package:device_run_test/src/features/authentication/screens/onboarding/onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  TextEditingController phoneNumberController = TextEditingController();
  bool isNotValidate = false;
  String errorText = '';

  void phoneNumbervalidation() async {
    RegExp pattern = RegExp(r'^(601)[0-46-9][0-9]{7,8}$');
    if (phoneNumberController.text.isNotEmpty) {
      if (pattern.hasMatch(phoneNumberController.text)) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => OTPVerifyPage()),
        );
        await http.post(Uri.parse(otpverification), body: {"phoneNumber": phoneNumberController.text});
      } else {
        setState(() {
          errorText = 'Invalid Phone Number Entered.';
          isNotValidate = true;
        });
      }
    } else {
      setState(() {
        errorText = 'Please Enter Your Phone Number.';
        isNotValidate = true;
      });
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(cDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(cAppLogo, height: size.height * 0.2),
            const SizedBox(height: cDefaultSize,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: cFormHeight - 30),
              //width:  double.infinity,
              height:  cFormHeight + 40,
              child: Form(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: CTextFormFieldTheme.lightInputDecorationTheme,
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Phone Number Starts with 60',
                      hintText: '60123456789', 
                      counterText: '',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value';
                      }
                      RegExp pattern = RegExp(r'^(601)[0-46-9][0-9]{7,8}$');
                      if (!pattern.hasMatch(value)) {
                        return 'Invalid phone number pattern';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5.0,),
            OutlinedButton(
              onPressed: () {
                phoneNumbervalidation();// Navigate to OTP
              },
              style: COutlinedButtonTheme.lightOutlinedButtonTheme.style,
              child: Center(
                  child: Text('Login', style: Theme.of(context).textTheme.headlineMedium,),
              ),
            ),
            const SizedBox(height: 5.0,),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                'Continue as Guest', 
                style: TextStyle(decoration: TextDecoration.underline, color: AppColors.cGreyColor3,), 
              ),
            ),
            //start biometric icon
            // const Text(
            //   'OR', 
            //   style: TextStyle(color: AppColors.cGreyColor3,
            //   )
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     IconButton(icon: const Icon(Icons.camera_front, size: 40.0), onPressed: () {null;},),
            //     IconButton(icon: const Icon(Icons.fingerprint, size: 40.0), onPressed: () {null;},),
            //     IconButton(icon: const Icon(Icons.qr_code, size: 40.0), onPressed: () {null;},),
            //   ],
            // ),
            // Add more widgets as needed
            
          ],
        ),
      ),
    );
  }
}