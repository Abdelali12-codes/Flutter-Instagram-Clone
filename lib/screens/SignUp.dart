import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/screens/App.dart';
import 'package:flutter_instagram_clone/screens/App2.dart';

class SignUp extends StatefulWidget {
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection("users");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _firstName,
                        decoration: InputDecoration(
                            labelText: 'Enter your FirstName....'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your First Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastName,
                        decoration: InputDecoration(
                            labelText: 'Enter your LastName...'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your last Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _email,
                        decoration:
                            InputDecoration(labelText: 'Enter your Email...'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                            labelText: 'Enter your Password...'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Password';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: OutlineButton(
                          child: Text('SignUp'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _registerAccount();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _registerAccount() async {
    String email = _email.text;
    final password = _password.text;

    final User user = (await _auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password))
        .user;

    print('${_email.text}');
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    }
    await user.updateProfile(displayName: _firstName.text);
    await _firestore.collection("users").doc(user.uid).set({
      'firstName': _firstName.text,
      'lastName': _lastName.text,
      'email': _email.text
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => App2()));
  }
}
