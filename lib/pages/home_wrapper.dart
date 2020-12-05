import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/pages/Instahome.dart';
import 'package:flutter_instagram_clone/pages/login_profile.dart';
import 'package:flutter_instagram_clone/screens/loading.dart';

class HomeWrapper extends StatelessWidget {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: users.doc(_auth.currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            if (!snapshot.data.data()['userRole']) {
              return LoginProfile();
            } else {
              return App(
                uid: _auth.currentUser.uid,
              );
            }
          }
        });
  }
}
