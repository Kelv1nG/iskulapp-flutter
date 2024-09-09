import 'package:flutter/material.dart';
import 'package:school_erp/pages/home_page.dart'; // Import HomePage

class LoginBody extends StatefulWidget {
  final VoidCallback onForgotPassword; // Callback to switch to Forgot Password

  const LoginBody({super.key, required this.onForgotPassword});

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _obscureText = true; // State variable to manage password visibility

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Space at the top
              const Text(
                'Hi Student',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black87),
                textAlign: TextAlign.start,
              ),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 40),
              const Text(
                'Mobile Number/Email',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Password',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              TextField(
                obscureText: _obscureText, // Toggle password visibility
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black45,
                    ),
                    onPressed:
                        _togglePasswordVisibility, // Toggle visibility on press
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }, // Navigate to HomePage
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5278C1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_back, // Right-facing arrow icon
                      ),
                      label: const Text("Sign in"),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: widget.onForgotPassword, // Switch to Forgot Password
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFF5278C1)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
