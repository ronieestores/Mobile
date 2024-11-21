import 'package:flutter/material.dart';
import 'package:mobile_app/login_page.dart'; // Adjust the path as needed
import 'dart:async';
import 'otp_page.dart'; // Adjust the path as needed

// Preloader before navigating to SignInPage
class PreloaderIntro extends StatefulWidget {
  const PreloaderIntro({super.key});

  @override
  PreloaderIntroState createState() => PreloaderIntroState();
}

class PreloaderIntroState extends State<PreloaderIntro> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) { // Ensure the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // Updated background color
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDAA520)), // Preloader color
          strokeWidth: 8.0,
        ),
      ),
    );
  }
}

// Preloader before navigating to OTP page
class PreloaderToOTP extends StatefulWidget {
  const PreloaderToOTP({super.key});

  @override
  PreloaderToOTPState createState() => PreloaderToOTPState();
}

class PreloaderToOTPState extends State<PreloaderToOTP> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) { // Ensure the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OTPPage(email: '', otpCode: 'a',)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // Updated background color
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDAA520)), // Preloader color
          strokeWidth: 8.0,
        ),
      ),
    );
  }
}
