import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/call.dart';
// import 'package:flutter_instagram_clone/provider/user_provider.dart';
import 'package:flutter_instagram_clone/resources/call_methods.dart';
import 'package:flutter_instagram_clone/screens/callscreen/pickup/pickup_screen.dart';
// import 'package:provider/provider.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CallMethods callMethods = CallMethods();
  PickupLayout({this.scaffold});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: callMethods.callStream(uid: _auth.currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.data() != null) {
          Call call = Call.fromMap(snapshot.data.data());

          if (!call.hasDialled) {
            return PickupScreen(call: call);
          }
          return scaffold;
        }

        return scaffold;
      },
    );
  }
}
