import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram_clone/configs/firebase_messaging.dart';
import 'package:flutter_instagram_clone/constants/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Activityy extends StatefulWidget {
  @override
  _ActivityyState createState() => _ActivityyState();
}

class _ActivityyState extends State<Activityy> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool show = false;
  String token = "";
  String otheruserId = "O1YZifLxRXgTBpaBVuIvxvJT1tg1";
  // final pref = await SharedPreferences.getInstance();
  void sharedPrefToken({String currentUser}) async {
    final pref = await SharedPreferences.getInstance();
    DocumentSnapshot data =
        await firestore.collection("users").doc(currentUser).get();

    pref.setString("token", data.data()['token']);
  }

  Future<void> getTokenWidget() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      token = pref.getString("token");
    });
  }

  Future<void> sendNotificationMessageToPeerUser(messageType) async {
    final pref = await SharedPreferences.getInstance();
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$firebaseCloudserverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': messageType == 'text' ? 'abdelali' : '(Photo)',
            'title': 'abdelali',
            'badge': '5', //'$unReadMSGCount'
            "sound": "default"
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'chatroomid': "hhhh",
          },
          'to': pref.getString("token"),
        },
      ),
    );
  }

  @override
  void initState() {
    sharedPrefToken(currentUser: otheruserId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Activity",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              RaisedButton(
                child: Text("logout"),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              Text(
                "Today",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // today notifications

              Text(
                "Yesterday",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // yesterday notifications
              Text(
                "This week",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // this week notifications

              Text(
                "This month",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              // this month notifications

              //
              Text(
                "Suggestions for you",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Column(
                  children: list.map((image) {
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/spinner.gif",
                        image: image.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: SizedBox(
                    width: 130,
                    child: Text(
                      image.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  subtitle: SizedBox(
                    width: 120,
                    child: Text(
                      image.username,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  trailing: Container(
                    width: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          color: Colors.blue,
                          height: 30,
                          minWidth: 40,
                          child: Text(
                            "follow",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                );
              }).toList())
            ],
          ),
        ));
  }
}
