import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'dart:async'; 
import 'responsive_nav_bar_page.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 
import 'package:fluttertoast/fluttertoast.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class OTPPage extends StatefulWidget {
  final String email; 

  const OTPPage({super.key, required this.email, required String otpCode});

  @override
  OTPPageState createState() => OTPPageState();
}

class OTPPageState extends State<OTPPage> {
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  bool _isLoading = false; 
  bool _isButtonEnabled = false; 
  bool _canResendOTP = false; 
  int _resendTimeout = 30; 
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer(); 
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _resendTimer?.cancel(); 
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        // Move to the previous field if current field is empty
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

  void _handleOnChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to the next field if the value is a single character
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    }
    // Update button state
    _updateButtonState();
  }

  void _updateButtonState() {
    // Check if all fields are filled
    bool allFilled = _controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      _isButtonEnabled = allFilled;
    });
  }

  void _showPreloaderAndNavigateToHome() {
    setState(() {
      _isLoading = true; // Show preloader
    });

    // Simulate 2-3 seconds delay before navigating to ResponsiveNavBarPage
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ResponsiveNavBarPage()), // Change to VotePage if needed
      );
    });
  }

  void _startResendTimer() {
    setState(() {
      _canResendOTP = false; // Disable the resend option
      _resendTimeout = 30; // Reset the timeout
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendTimeout--;
      });
      if (_resendTimeout == 0) {
        _resendTimer?.cancel();
        setState(() {
          _canResendOTP = true; // Enable the resend option
        });
      }
    });
  }

  void _resendOTP() {
    if (_canResendOTP) {
      _startResendTimer(); // Start the timer again
      _sendOTP(); // Send the new OTP
    }
  }

  Future<void> _sendOTP() async {
    final response = await http.post(
      Uri.parse('http://192.168.193.249/Desktop/api.php'), // Replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': widget.email}), // Send the user's email
    );

    if (response.statusCode == 200) {
      // Handle successful OTP resend response if necessary
      if (mounted) {
        Fluttertoast.showToast(
          msg: "OTP resent successfully!",
          backgroundColor: Colors.green, // Green background for success
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // Position of the toast
        );
      }
    } else {
      // Handle error response
      final responseBody = json.decode(response.body);
      String errorMessage = responseBody['message'] ?? 'Failed to resend OTP.';
      if (mounted) {
        Fluttertoast.showToast(
          msg: errorMessage,
          backgroundColor: Colors.red, // Red background for error
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM, // Position of the toast
        );
      }
    }
  }

Future<void> _verifyOTP() async {
  String enteredOTP = _controllers.map((controller) => controller.text).join('');

  // Call your API to verify the OTP
  final response = await http.post(
    Uri.parse('http://192.168.193.249/Desktop/api.php'), // Replace with your actual verification endpoint
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': widget.email, 'otp_code': enteredOTP}),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['message'] == 'OTP verified successfully.') {
      // OTP verified successfully, store user ID and navigate
      String userId = responseBody['user_id'].toString(); // Convert to String
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId); // Store the user ID

      // Proceed to the next page
      if (mounted) {
        _showPreloaderAndNavigateToHome(); // Proceed to vote_page.dart
      }
    } else {
      // Show error message if OTP is invalid
      if (mounted) {
        Fluttertoast.showToast(
          msg: responseBody['message'],
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  } else {
    // Handle API errors such as invalid OTP or expired OTP
    final responseBody = json.decode(response.body);
    String errorMessage = responseBody['message'] ?? 'An error occurred. Please try again.';
    if (mounted) {
      Fluttertoast.showToast(
        msg: errorMessage,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _unfocusAll(); // Unfocus all text fields when clicking outside
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), // Background color to match vote_page
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50.0),
              const Center(
                child: Text(
                  "Enter OTP",
                  style: TextStyle(
                    color: Colors.black, // Text color to match vote_page
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50.0, // Adjust width if needed
                    height: 60.0, // Adjust height to ensure adequate space
                    child: Focus(
                      onKeyEvent: (node, event) {
                        _handleKeyEvent(event, index);
                        // Return ignored so that the default behavior (input of numbers) still works
                        return KeyEventResult.ignored;
                      },
                      child: TextField(
                        focusNode: _focusNodes[index],
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        style: const TextStyle(
                          fontSize: 24.0,
                          color: Colors.black, // Text color to match vote_page
                        ),
                        cursorColor: Colors.black, // Cursor color to match text color
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE0E0E0), // Fill color to match vote_page
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none, // Remove border for default state
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.grey, // Border color when not focused
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.blue, // Border color when focused
                              width: 2.0,
                            ),
                          ),
                          counterText: '',
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        onChanged: (value) {
                          _handleOnChanged(value, index);
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: GestureDetector(
                  onTap: _canResendOTP ? _resendOTP : null,
                  child: Text(
                    _canResendOTP ? "RESEND OTP" : "Resend in $_resendTimeout seconds",
                    style: TextStyle(
                      color: _canResendOTP ? Colors.blue : Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDAA520)), // Preloader color
                        strokeWidth: 8.0,
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDAA520), // Proceed button color
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: _isButtonEnabled ? _verifyOTP : null, // Verify OTP
                      child: const Text(
                        "Proceed",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _unfocusAll() {
    for (var focusNode in _focusNodes) {
      focusNode.unfocus();
    }
  }
}
