import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/screens/App.dart';

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection("users");

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignIn'),
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
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: "Enter your email...",
                        ),
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
                          child: Text('SignIn'),
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

    final User user = (await _auth.signInWithEmailAndPassword(
            email: email.trim(), password: password))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    }
    // await user.updateProfile(displayName: _firstName.text);
    // await _firestore.collection("users").doc(user.uid).set({
    //   'firstName': _firstName.text,
    //   'lastName': _lastName.text,
    //   'email': _email.text
    // });

    Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
  }
}
