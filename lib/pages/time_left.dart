import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/models/call.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/resources/firebase_repository.dart';
// import '../screens/callscreen/call_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_instagram_clone/utils/call_utilities.dart';
// import './receiver_left.dart';

class TimeLeft extends StatefulWidget {
  final Call call;
  final String receiverid;
  final String roomId;
  TimeLeft({this.call, this.receiverid, this.roomId});
  @override
  _TimeLeftState createState() => _TimeLeftState();
}

class _TimeLeftState extends State<TimeLeft> {
  FirebaseRepository _repository = FirebaseRepository();
  CollectionReference messages = FirebaseFirestore.instance.collection("rooms");
  Usermodel sender;
  Usermodel receiver;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      _repository.getCurrentUserDetailsofuid(uid: user.uid).then((currentuser) {
        sender = currentuser;
        _repository
            .getCurrentUserDetailsofuid(uid: widget.call.receiverId)
            .then((otheruser) {
          receiver = otheruser;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xFF373A40),
                  Color(0xFF373A40),
                  Color(0xFF92817A),
                  Color(0xFF92817A),
                  Color(0xFF92817A),
                  Color(0xFF92817A),
                ])),
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // color: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  width: 180,
                  height: 180,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/spinner.gif",
                            image:
                                "https://images.pexels.com/photos/433452/pexels-photo-433452.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.red,
                        ),
                      ),
                      Positioned(
                          left: 35,
                          top: 35,
                          child: Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF92817A),
                            ),
                            child: Container(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/spinner.gif",
                                  image:
                                      "https://firebasestorage.googleapis.com/v0/b/instagram-clone-84392.appspot.com/o/t%C3%A9l%C3%A9chargement.jpg?alt=media&token=7cbd47b1-ff0a-40a0-865d-ddf0b6ef84f4",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.blue,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  "Didn't join",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: Icon(
                                Entypo.cross,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: IconButton(
                                icon: Icon(
                                  Feather.video,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await [
                                    Permission.camera,
                                    Permission.microphone,
                                    Permission.storage
                                  ].request();
                                  CallUtils.dial(
                                      from: sender,
                                      to: receiver,
                                      roomId: widget.call.channelId,
                                      context: context);
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Call Again",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
