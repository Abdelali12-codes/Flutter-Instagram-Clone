import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/pages/activity.dart';
import 'package:flutter_instagram_clone/pages/profile.dart';
import 'package:flutter_instagram_clone/pages/searchcom.dart';
import 'package:flutter_instagram_clone/pages/upload_image.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/enum/user_state.dart';
// import 'package:flutter_instagram_clone/provider/user_provider.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:flutter_instagram_clone/resources/notificationController.dart';
import 'package:flutter_instagram_clone/screens/callscreen/pickup/pickup_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_instagram_clone/screens/loading.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Instagram.dart';
import 'package:fluttertoast/fluttertoast.dart';

class App extends StatefulWidget {
  final String uid;
  App({this.uid});
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseMessaging _messaging = FirebaseMessaging();
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  var index = 0;
  bool isTaped = false;
  var _pages = [
    Home(),
    SearchCom(),
    Upload(),
    Activityy(),
    Profile(),
  ];

  @override
  void initState() {
    // _firebaseMessageConfg();

    _firebaseMethods.setUserState(
        userId: _auth.currentUser.uid, userState: UserState.Online);
    WidgetsBinding.instance.addObserver(this);
    // registerNotifications();

    super.initState();
  }

  // the notifications permmisssions
  // void registerNotifications() {
  //   _messaging.requestNotificationPermissions();

  //   _messaging.configure(onMessage: (Map<String, dynamic> message) {
  //     return;
  //   }, onResume: (Map<String, dynamic> message) {
  //     print('onResume: $message');
  //     return;
  //   }, onLaunch: (Map<String, dynamic> message) {
  //     print('onLaunch: $message');
  //     return;
  //   });
  //   _messaging.getToken().then((token) {
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(_auth.currentUser.uid)
  //         .update({'pushToken': token});
  //   }).catchError((err) {
  //     Fluttertoast.showToast(msg: err.message.toString());
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   WidgetsBinding.instance.removeObserver(this);
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _firebaseMethods.setUserState(
            userId: _auth.currentUser.uid, userState: UserState.Online);
        break;

      case AppLifecycleState.inactive:
        _firebaseMethods.setUserState(
            userId: _auth.currentUser.uid, userState: UserState.Offline);
        break;

      case AppLifecycleState.paused:
        _firebaseMethods.setUserState(
            userId: _auth.currentUser.uid, userState: UserState.Waiting);
        break;

      case AppLifecycleState.detached:
        _firebaseMethods.setUserState(
            userId: _auth.currentUser.uid, userState: UserState.Offline);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return _auth.currentUser.uid != null
        ? StreamBuilder<DocumentSnapshot>(
            stream: users.doc(_auth.currentUser.uid).snapshots(),
            builder: (context, snapshot) => snapshot.hasData
                ? PickupLayout(
                    scaffold: Scaffold(
                    body: _pages[index],
                    bottomNavigationBar: BottomNavigationBar(
                      currentIndex: index,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedItemColor: Colors.black,
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                            label: "Home", icon: Icon(Foundation.home)),
                        BottomNavigationBarItem(
                            label: 'Search', icon: Icon(Feather.search)),
                        BottomNavigationBarItem(
                            label: 'Add', icon: Icon(Feather.plus_square)),
                        BottomNavigationBarItem(
                            label: 'heart', icon: Icon(Feather.heart)),
                        BottomNavigationBarItem(
                            label: 'profile',
                            icon: !isTaped
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isTaped = true;
                                      });
                                    },
                                    child:
                                        snapshot.data.data()['photourl'] != null
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot.data
                                                        .data()['photourl']),
                                                maxRadius: 10,
                                              )
                                            : Container(),
                                  )
                                : Container(
                                    width: 25,
                                    height: 25,
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            style: BorderStyle.solid,
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: FadeInImage.assetNetwork(
                                          image:
                                              snapshot.data.data()['photourl'],
                                          placeholder:
                                              "assets/images/spinner.gif",
                                        )),
                                  ))
                      ],
                      onTap: (i) {
                        print(widget.uid);
                        setState(() {
                          index = i;
                        });
                      },
                    ),
                  ))
                : Loading(),
          )
        : CircularProgressIndicator();
  }
}
