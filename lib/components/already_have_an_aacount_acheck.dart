import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  AlreadyHaveAnAccountCheck({Key key, this.login = true, this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an Account ?" : "Already have an Account ?",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          // onTap: press,
          child: login
              ? GestureDetector(
                  onTap: () {
                    press();
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              : GestureDetector(
                  onTap: press,
                  child: Text("Sign In",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold)),
                ),
        )
      ],
    );
  }
}
