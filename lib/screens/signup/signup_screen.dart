import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screens/signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  final Function toggle;
  SignUpScreen({this.toggle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        toggle: toggle,
      ),
    );
  }
}
