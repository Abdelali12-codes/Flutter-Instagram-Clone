import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/camera.dart';
import 'package:flutter_instagram_clone/pages/chat.dart';
import 'package:flutter_instagram_clone/pages/online_indicator.dart';
// import 'package:flutter_instagram_clone/badges/messageKind.dart';
import 'package:flutter_instagram_clone/pages/search.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:jiffy/jiffy.dart';
import '../utils/time_ago_since_now.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_instagram_clone/badges/story.dart';
// import 'package:flutter_instagram_clone/models/message_model.dart';

class Messages extends StatefulWidget {
  final String uid;
  Messages({this.uid});
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool istaped = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference rooms = FirebaseFirestore.instance.collection("users");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isgreater = false;
  @override
  void initState() {
    super.initState();
    firebaseMethods.getroomshasunreadMessages(
        currentUser: _auth.currentUser.uid);
  }

  @override
  void dispose() {
    super.dispose();
    firebaseMethods.getroomshasunreadMessages(
        currentUser: _auth.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          title: Text(
            'Activity',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Feather.arrow_left, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                FontAwesome.list_ul,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
                icon: Icon(
                  FontAwesome.edit,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: rooms
              .doc(_auth.currentUser.uid)
              .collection("rooms")
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) => snapshot.hasData &&
                  snapshot.data.docs.length >= 1
              ? Builder(
                  builder: (BuildContext context) => Container(
                    // color: Colors.red,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              istaped = true;
                            });
                            dynamic result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search()));
                            if (result == 'change') {
                              setState(() {
                                istaped = false;
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.grey[400],
                                    style: BorderStyle.solid,
                                    width: 2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(children: [
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(
                                      EvilIcons.search,
                                      color:
                                          !istaped ? Colors.grey : Colors.black,
                                    ),
                                    iconSize: !istaped ? 30 : 40,
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Search",
                                      style: TextStyle(color: Colors.grey)),
                                ]),
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    Octicons.settings,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // MessageKind()
                        Expanded(
                          child: Container(
                            // color: Colors.amber,
                            // the rooms
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot room =
                                    snapshot.data.docs[index];

                                return StreamBuilder<DocumentSnapshot>(
                                  stream: users
                                      .doc(room.data()['with'])
                                      .snapshots(),
                                  builder: (context, snap) => snap.hasData
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Chat(
                                                username: snap.data
                                                    .data()['username'],
                                                fullName: snap.data
                                                    .data()['fullname'],
                                                image: snap.data
                                                    .data()['photourl'],
                                                roomId: room.id,
                                                receiverid: room.data()['with'],
                                              );
                                            }));
                                          },
                                          child:
                                              StreamBuilder<DocumentSnapshot>(
                                                  stream: users
                                                      .doc(room.data()['with'])
                                                      .snapshots(),
                                                  builder: (context,
                                                          snapshotdoc) =>
                                                      snapshotdoc.hasData
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 7),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: StreamBuilder<
                                                                      QuerySnapshot>(
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "rooms")
                                                                      .doc(
                                                                          room.id)
                                                                      .collection("messages")
                                                                      .where("unread", isEqualTo: true)
                                                                      .snapshots(),
                                                                  builder: (context, snap) => snap.hasData && snap.data.docs.length > 0
                                                                      ? StreamBuilder<QuerySnapshot>(
                                                                          stream:
                                                                              firebaseMethods.countUnreadMessages(roomId: room.id),
                                                                          builder:
                                                                              (context, snapshotmsg) {
                                                                            if (snapshotmsg.hasData &&
                                                                                snapshotmsg.data != null) {
                                                                              int countedmsg = snapshotmsg.data.docs.length;
                                                                              String uid = snapshotmsg.data.docs[0].data()['senderId'];
                                                                              return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    snapshotdoc.data.data()['state'] == 1
                                                                                        ? OnlinIndicator(
                                                                                            photourl: snapshotdoc.data.data()['photourl'],
                                                                                          )
                                                                                        : CircleAvatar(
                                                                                            radius: 30,
                                                                                            backgroundImage: NetworkImage(snapshotdoc.data.data()['photourl']),
                                                                                          ),
                                                                                    SizedBox(
                                                                                      width: 20.0,
                                                                                    ),
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          snapshotdoc.data.data()["fullname"],
                                                                                          style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 5.0,
                                                                                        ),
                                                                                        Container(
                                                                                            width: size.width * 0.50,
                                                                                            child: Row(
                                                                                              children: [
                                                                                                Container(
                                                                                                  constraints: BoxConstraints(maxWidth: 120),
                                                                                                  margin: EdgeInsets.only(right: 6),
                                                                                                  child: (countedmsg == 1 && uid != _auth.currentUser.uid)
                                                                                                      ? Text(
                                                                                                          room.data()['message'],
                                                                                                          maxLines: 1,
                                                                                                          style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                                                                                          overflow: TextOverflow.ellipsis,
                                                                                                        )
                                                                                                      : (countedmsg > 1 && uid != _auth.currentUser.uid)
                                                                                                          ? snapshotdoc.data.data()['isTyping']
                                                                                                              ? Text(
                                                                                                                  "Typing...",
                                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                                                )
                                                                                                              : Text(
                                                                                                                  "$countedmsg new messages.",
                                                                                                                  maxLines: 1,
                                                                                                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                                )
                                                                                                          : snapshotdoc.data.data()['isTyping']
                                                                                                              ? Text(
                                                                                                                  "Typing...",
                                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                                                )
                                                                                                              : Text(
                                                                                                                  "${room.data()['message']}.",
                                                                                                                  maxLines: 1,
                                                                                                                  style: TextStyle(
                                                                                                                    color: Colors.grey[500],
                                                                                                                    fontSize: 14.0,
                                                                                                                  ),
                                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                                ),
                                                                                                ),
                                                                                                snapshotdoc.data.data()['isTyping']
                                                                                                    ? Text("")
                                                                                                    : Container(
                                                                                                        child: (countedmsg == 1 && uid != _auth.currentUser.uid)
                                                                                                            ? Text('${timefromNow(time: room.data()['time']?.toDate())}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12))
                                                                                                            : (countedmsg > 1 && uid != _auth.currentUser.uid)
                                                                                                                ? Text('${timefromNow(time: room.data()['time']?.toDate())}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12))
                                                                                                                : Text('${timefromNow(time: room.data()['time']?.toDate())}',
                                                                                                                    style: TextStyle(
                                                                                                                      color: Colors.grey[500],
                                                                                                                    )))
                                                                                              ],
                                                                                            ))
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Container(
                                                                                  width: 70,
                                                                                  alignment: Alignment.center,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      (countedmsg == 1 && uid != _auth.currentUser.uid)
                                                                                          ? Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue))
                                                                                          : (countedmsg > 1 && uid != _auth.currentUser.uid)
                                                                                              ? Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue))
                                                                                              : Text(""),
                                                                                      Container(
                                                                                        child: IconButton(
                                                                                          padding: EdgeInsets.all(0),
                                                                                          icon: Icon(
                                                                                            Feather.camera,
                                                                                            color: (countedmsg == 1 && uid != _auth.currentUser.uid)
                                                                                                ? Colors.black
                                                                                                : (countedmsg > 1 && uid != _auth.currentUser.uid)
                                                                                                    ? Colors.black
                                                                                                    : Colors.grey[500],
                                                                                          ),
                                                                                          onPressed: () {},
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ]);
                                                                            }
                                                                            return Center(child: CircularProgressIndicator());
                                                                          },
                                                                        )
                                                                      : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              snapshotdoc.data.data()['state'] == 1
                                                                                  ? OnlinIndicator(
                                                                                      photourl: snapshotdoc.data.data()['photourl'],
                                                                                    )
                                                                                  : CircleAvatar(
                                                                                      radius: 30,
                                                                                      backgroundImage: NetworkImage(snapshotdoc.data.data()['photourl']),
                                                                                    ),
                                                                              SizedBox(
                                                                                width: 20.0,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    snapshotdoc.data.data()["fullname"],
                                                                                    style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5.0,
                                                                                  ),
                                                                                  Container(
                                                                                      width: size.width * 0.45,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Container(
                                                                                            constraints: BoxConstraints(maxWidth: 130),
                                                                                            margin: EdgeInsets.only(right: 6),
                                                                                            child: snapshotdoc.data.data()['isTyping']
                                                                                                ? Text(
                                                                                                    "Typing...",
                                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                                  )
                                                                                                : Text(
                                                                                                    "${room.data()['message']}.",
                                                                                                    maxLines: 1,
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.grey[500],
                                                                                                      fontSize: 14.0,
                                                                                                    ),
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                  ),
                                                                                          ),
                                                                                          snapshotdoc.data.data()['isTyping'] ? Text("") : Container(child: Text('${timefromNow(time: room.data()['time']?.toDate())}', style: TextStyle(color: Colors.grey[500])))
                                                                                        ],
                                                                                      ))
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                80,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                // Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue)),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(right: 8),
                                                                                  child: IconButton(
                                                                                    padding: EdgeInsets.all(0),
                                                                                    icon: Icon(
                                                                                      Feather.camera,
                                                                                      color: Colors.grey[500],
                                                                                    ),
                                                                                    onPressed: () {},
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ])))
                                                          : Center(child: CircularProgressIndicator())),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator()),
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.09,
                          width: double.infinity,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Camera()));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesome.camera,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }

  Widget isTyping({String receiverid}) {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection("users").doc(receiverid).snapshots(),
      builder: (context, snap) {
        if (snap.hasData && snap.data != null) {
          bool isTyping = snap.data.data()['isTyping'];
          if (isTyping) {
            return Text(
              "Typing...",
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          }
          return Text("");
        }
        return Text('');
      },
    );
  }
}
