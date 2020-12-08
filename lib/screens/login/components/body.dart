import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/pages/instagram_loading.dart';
import 'package:flutter_instagram_clone/components/already_have_an_aacount_acheck.dart';
import 'package:flutter_instagram_clone/components/rounded_button.dart';
import 'package:flutter_instagram_clone/components/rounded_input_field.dart';
import 'package:flutter_instagram_clone/components/rounded_password_field.dart';
// import 'package:flutter_instagram_clone/screens/instagram_loading.dart';
// import 'package:flutter_instagram_clone/screens/loading.dart';
import 'package:flutter_instagram_clone/screens/login/components/background.dart';
// import 'package:flutter_instagram_clone/screens/signup/signup_screen.dart';
// import 'package:flutter_instagram_clone/services/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:email_validator/email_validator.dart';

class Body extends StatefulWidget {
  final Function toggle;
  Body({
    Key key,
    this.toggle,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String emailerror = '';
  String passworderror = '';
  String error = '';
  String email = '';
  String password = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? InstaLoading()
        : Background(
            child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SvgPicture.asset(
                    "assets/icons/signin.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Your Email",
                    onChanged: (value) {
                      if (!EmailValidator.validate(value.trim())) {
                        setState(() {
                          emailerror = 'please Enter valid email';
                          error = '';
                        });
                      } else {
                        setState(() {
                          emailerror = '';
                          error = '';
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
                  RoundedPasswordField(onChanged: (value) {
                    if (!(value.length >= 8)) {
                      setState(() {
                        passworderror =
                            'the password must have at least 8 characters';
                        error = '';
                      });
                    } else {
                      setState(() {
                        passworderror = '';
                        error = '';
                      });
                    }
                    setState(() {
                      password = value;
                    });
                  }),
                  Text(
                    passworderror,
                    style: TextStyle(color: Colors.red),
                  ),
                  RoundedButton(
                      text: "LOGIN",
                      press: () async {
                        if (EmailValidator.validate(email.trim()) &&
                            password.length >= 8) {
                          setState(() {
                            loading = true;
                          });

                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email.trim(), password: password.trim());
                          } catch (e) {
                            setState(() {
                              error = e.message.toString();
                              loading = false;
                            });
                          }
                        }
                      }),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  AlreadyHaveAnAccountCheck(press: widget.toggle)
                ],
              ),
            ),
          ));
  }
}
