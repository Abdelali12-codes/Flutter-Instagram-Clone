import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screens/login/login_screen.dart';
import 'package:flutter_instagram_clone/screens/signup/signup_screen.dart';
import 'package:flutter_instagram_clone/screens/welcome/components/body.dart';

class WelcomeScreen extends StatefulWidget {
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool signin = true;
  void toggleForm() {
    setState(() {
      signin = !signin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return signin
        ? LoginScreen(
            toggle: toggleForm,
          )
        : SignUpScreen(
            toggle: toggleForm,
          );
  }
}
