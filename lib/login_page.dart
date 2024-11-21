import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'otp_page.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  bool _isObscured = true;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _unfocus() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

void _showPreloaderAndLogin() async {
  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
    String email = _emailController.text;
    String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://192.168.193.249/Desktop/api.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (!mounted) return;

    if (response.statusCode == 200) {
      // Successfully logged in, navigate to the next page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PreloaderToOTP(email: email, otpCode: ''),
        ),
      );
    } else {
      // Show error message if login fails
      Fluttertoast.showToast(
        msg: 'Invalid email or password.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } else {
    // Validate if email or password fields are empty
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter both Email and Password.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (_emailController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Email.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (_passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter your Password.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF), 
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome to Litex Vote!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48.0),
              TextField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress, 
                autocorrect: false, 
                textInputAction: TextInputAction.next, 
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email, color: Colors.black),
                  labelText: "Email",
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.black54), 
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Color(0xFFE0E0E0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF007BFF),
                      width: 2.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: _isObscured,
                keyboardType: TextInputType.text, 
                autocorrect: false, 
                textInputAction: TextInputAction.done, 
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                  labelText: "Password",
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: Colors.black54), 
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: const Color(0xFFE0E0E0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Color(0xFF007BFF),
                      width: 2.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDAA520), 
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _showPreloaderAndLogin, 
                child: const Text(
                  "Log In",
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PreloaderToOTP extends StatefulWidget {
  final String email; 
  final String otpCode; 

  const PreloaderToOTP({super.key, required this.email, required this.otpCode});

  @override
  PreloaderToOTPState createState() => PreloaderToOTPState();
}

class PreloaderToOTPState extends State<PreloaderToOTP> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OTPPage(email: widget.email, otpCode: widget.otpCode)),
      );
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
