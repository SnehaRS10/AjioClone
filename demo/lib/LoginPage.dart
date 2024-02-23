import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'SignupPage.dart'; // Import the SignupPage.dart file
import 'account_page.dart';

class LoginPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle login
  Future<void> _loginWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // If login is successful, navigate to AccountPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AccountPage()),
      );
    } catch (e) {
      print('Login Error: $e');
      // Handle login error, show message to the user
    }
  }


  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log In',
          style: TextStyle(color: Colors.black), // Set the title color to black
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ajio logo (replace with your image path)
              Image.asset('assets/ajio_logo.png', height: 100.0, width: 100.0),
              SizedBox(height: 20.0),

              // Email field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  onChanged: (value) {
                    email = value; // Update email variable on change
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your Email or Username',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              // Password field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  onChanged: (value) {
                    password = value; // Update password variable on change
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              // Login button with increased padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle login attempt
                    _loginWithEmailAndPassword(context, email, password);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.0), // Increased padding
                    child: Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // New user link (Ajio-style button)
              ElevatedButton(
                onPressed: () {
                  // Navigate to the SignupPage when the button is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                child: Text(
                  'New to Ajio? Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
