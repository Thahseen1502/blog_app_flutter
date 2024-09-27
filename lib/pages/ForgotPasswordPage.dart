import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB81736),
              Color(0xff2B1836)
            ], // Matches WelcomeScreen background
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 130),
                    Image.asset(
                      'images/logo.png', // Replace with the correct image asset
                      height: 200,
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white, // White text color to match theme
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your email address below to receive a password reset link.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors
                            .white70, // Lightened white for secondary text
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                          filled: true,
                          fillColor: Colors.black
                              .withOpacity(0.2), // Semi-transparent background
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                              width: 0.5, // Adjust the border width as needed
                            ),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors
                                .yellow, // Set error message color to yellow
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!isValidEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'\s')), // Prevent spaces
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.white, // White button background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ResetSubmitPage(), // Navigate to ResetSubmitPage
                            //   ),
                            // );
                          }
                        },
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors
                                .black, // Black text color on white background
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String value) {
    String emailRegex = r'^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$';
    return RegExp(emailRegex).hasMatch(value);
  }
}
