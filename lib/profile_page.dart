import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? email;
  bool isLoading = true;
  String? userId;
  
  get logger => null;

  @override
  void initState() {
    super.initState();
    _getUserId(); // Fetch the userId from SharedPreferences
  }

  // Method to fetch userId from SharedPreferences
  void _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id');  // Fetching the user_id from SharedPreferences

    if (userId == null) {
      if (mounted) {  // Guard the context-dependent code with `mounted`
        Fluttertoast.showToast(
          msg: 'User not logged in. Please verify OTP first.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
      return;
    }
    // Fetch user info after retrieving the userId
    _fetchUserInfo(userId!);
  }

  // Method to fetch user info
  void _fetchUserInfo(String userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.193.249/Desktop/api.php?action=fetch_user_info&user_id=$userId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        if (mounted) {  // Guard the context-dependent code with `mounted`
          setState(() {
            fullName = data['user']['full_name'];
            email = data['user']['email'];
            isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          _showErrorDialog(data['message']);
        }
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        _showErrorDialog("Failed to load user information.");
      }
    }
  }

  void _showErrorDialog(String message) {
    if (mounted) {  // Guard the context-dependent code with `mounted`
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            content: Text(message, style: GoogleFonts.poppins(fontSize: 14.0)),
            actions: [
              TextButton(
                child: Text("OK", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

void _changePassword(String userId) async {
  if (_formKey.currentState?.validate() ?? false) {
    try {
      // Prepare the request body as JSON
      final Map<String, dynamic> requestBody = {
        'user_id': userId,
        'current_password': _currentPasswordController.text,
        'new_password': _newPasswordController.text,
        'confirm_password': _confirmPasswordController.text,
      };

      // Make the HTTP request
      final response = await http.post(
        Uri.parse('http://192.168.193.249/Desktop/api.php?action=change_password'),
        headers: {'Content-Type': 'application/json'}, // Set Content-Type to application/json
        body: json.encode(requestBody), // Encode the request body as JSON
      );

      // Check if the response is JSON; if not, it's likely an error
      if (response.headers['content-type']?.contains('application/json') != true) {
        logger.e("Error: Received unexpected response type.");
        _showErrorDialog("Unexpected error. Please try again.");
        return;
      }

      // Parse the response body
      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PreloaderToThankYou()),
          );
        }
      } else {
        _showErrorDialog(data['message']);
      }
    } catch (e) {
      logger.e("Request failed: $e");
      _showErrorDialog("Network error. Please try again.");
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color(0xFFFFFFFF),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader("Profile Information"),
                      _buildProfileInfoRow("Full Name:", fullName ?? "Loading..."),
                      _buildProfileInfoRow("Email:", email ?? "Loading..."),
                      const SizedBox(height: 24.0),
                      _buildSectionHeader("Change Password"),
                      _buildPasswordForm(),
                      const SizedBox(height: 24.0),
                      Text(
                        "For changes to your full name or email, please contact the admin.",
                        style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          // Add action for contacting support
                        },
                        child: Text(
                          "Contact Admin: Admin123@gmail.com",
                          style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 16.0, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

Widget _buildPasswordForm() {
  return Form(
    key: _formKey,
    child: Column(
      children: [
        _buildPasswordTextField("Current Password", _currentPasswordController, hintText: "Enter your current password"),
        const SizedBox(height: 16.0),
        _buildPasswordTextField("New Password", _newPasswordController, hintText: "Enter your new password"),
        const SizedBox(height: 16.0),
        _buildPasswordTextField("Confirm New Password", _confirmPasswordController, hintText: "Re-enter your new password"),
        const SizedBox(height: 32.0),
        AnimatedButton(
          height: 50,
          width: 200,
          text: 'Change Password',
          isReverse: true,
          selectedTextColor: Colors.black,
          backgroundColor: const Color(0xFFDAA520),
          borderColor: const Color(0xFFDAA520),
          borderRadius: 10,
          onPress: () {
            if (_newPasswordController.text == _confirmPasswordController.text) {
              // Pass dynamic user ID and proceed to change password
              _changePassword(userId!);
            } else {
              _showErrorDialog('New password and confirm password do not match');
            }
          },
        ),
      ],
    ),
  );
}


  Widget _buildPasswordTextField(String labelText, TextEditingController controller, {required String hintText}) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}


class PreloaderToThankYou extends StatefulWidget {
  const PreloaderToThankYou({super.key});

  @override
  PreloaderToThankYouState createState() => PreloaderToThankYouState();
}

class PreloaderToThankYouState extends State<PreloaderToThankYou> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ThankYouPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDAA520)),
          strokeWidth: 8.0,
        ),
      ),
    );
  }
}

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Password Updated!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}