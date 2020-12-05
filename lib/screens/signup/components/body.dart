import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/components/already_have_an_aacount_acheck.dart';
import 'package:flutter_instagram_clone/components/rounded_button.dart';
import 'package:flutter_instagram_clone/components/rounded_input_field.dart';
import 'package:flutter_instagram_clone/components/rounded_password_field.dart';
// import 'package:flutter_instagram_clone/screens/login/login_screen.dart';
import 'package:flutter_instagram_clone/screens/signup/components/background.dart';
import 'package:flutter_instagram_clone/screens/signup/components/or_divider.dart';
import 'package:flutter_instagram_clone/screens/signup/components/social_icon.dart';

import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  final Function toggle;
  Body({this.toggle});
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = '';
  String password = '';
  String error = '';
  String emailerror = '';
  String passworderror = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                "assets/icons/myapp.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  if (!EmailValidator.validate(email.trim())) {
                    setState(() {
                      emailerror = 'Please Enter a valid Email';
                    });
                  } else {
                    setState(() {
                      emailerror = '';
                    });
                  }
                  setState(() {
                    email = value;
                  });
                },
              ),
              Text(
                emailerror,
                style: TextStyle(color: Colors.red),
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  if (!(value.length >= 8)) {
                    setState(() {
                      password =
                          'The password filed should have at least 8 characters';
                    });
                  } else {
                    setState(() {
                      password = '';
                    });
                  }
                  setState(() {
                    password = value;
                  });
                },
              ),
              Text(
                passworderror,
                style: TextStyle(color: Colors.red),
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  if (EmailValidator.validate(email.trim()) &&
                      password.length >= 8) {
                    setState(() {
                      isloading = true;
                    });
                    try {
                      UserCredential user =
                          await _auth.createUserWithEmailAndPassword(
                              email: email.trim(), password: password.trim());

                      await users.doc(user.user.uid).set({
                        'username': "",
                        'fullname': "",
                        'photourl': "",
                        'blockedby': [],
                        'usersblocked': [],
                        'callrefused': false,
                        'followers': [],
                        'following': [],
                        'postsliked': [],
                        'token': "",
                        'phone': "",
                        "category": "",
                        "gender": "",
                        "website": "",
                        'userRole': false,
                      });
                      // User user = result.user;
                    } catch (e) {
                      setState(() {
                        isloading = false;
                        error = '${e.message}';
                      });
                    }
                  }
                },
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(login: false, press: widget.toggle),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconsrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconsrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconsrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
