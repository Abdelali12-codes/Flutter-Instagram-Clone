import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screens/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  final Function toggle;
  LoginScreen({this.toggle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(toggle: toggle),
    );
  }
}
