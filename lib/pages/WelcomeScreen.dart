import 'package:blog_app/pages/loginScreen.dart';
import 'package:blog_app/pages/regScreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff2B1836)],
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Image(image: AssetImage('images/logo.png')),
            ),
            const SizedBox(height: 100),
            const Text(
              'Welcome Back',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => loginScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const regScreen()),
                );
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white.withOpacity(0.5),
                    thickness: 0.5,
                    indent: 40,
                    endIndent: 20,
                  ),
                ),
                const Text(
                  'Or login with',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white.withOpacity(0.5),
                    thickness: 0.5,
                    indent: 20,
                    endIndent: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset('images/google.png'),
                  iconSize: 10,
                  onPressed: () {
                    // Handle Google login
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Image.asset('images/fb.png'),
                  iconSize: 10,
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Image.asset('images/twitter.png'),
                  iconSize: 10,
                  onPressed: () {
                    // Handle Twitter login
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
