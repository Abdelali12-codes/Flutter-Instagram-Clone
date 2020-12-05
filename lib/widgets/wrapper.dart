import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/pages/Instahome.dart';
import 'package:flutter_instagram_clone/pages/home_wrapper.dart';
import 'package:flutter_instagram_clone/screens/login/login_screen.dart';
import 'package:flutter_instagram_clone/screens/welcome/welcome_screen.dart';
// import 'package:flutter_instagram_clone/badges/Instahome.dart';
// import 'package:flutter_instagram_clone/models/users.dart';
// import 'package:flutter_instagram_clone/screens/welcome/welcome_screen.dart';
// import 'package:flutter_instagram_clone/services/user.dart';
// import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserClass>(context);
    // return user != null ? App() : WelcomeScreen();
    return StreamBuilder<User>(
      stream: _auth.authStateChanges(),
      builder: (context, user) {
        if (user.data == null) {
          return WelcomeScreen();
        } else {
          print(_auth.currentUser.uid);
          return HomeWrapper();
        }
      },
    );
    // we wil check either the user is signed in or not
  }
}
