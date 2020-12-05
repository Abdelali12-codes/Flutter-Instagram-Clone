import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_instagram_clone/badges/cached_image.dart';
import 'package:flutter_instagram_clone/pages/fullphoto.dart';
import 'package:flutter_instagram_clone/pages/message_input.dart';
import 'package:flutter_instagram_clone/pages/online_indicator.dart';
import 'package:flutter_instagram_clone/pages/profile_user.dart';
import 'package:flutter_instagram_clone/constants/const.dart';
// import 'package:flutter_instagram_clone/badges/video_call.dart';
import 'package:flutter_instagram_clone/constants/strings.dart';
import 'package:flutter_instagram_clone/models/message.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/resources/firebaseController.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:flutter_instagram_clone/resources/firebase_repository.dart';
import 'package:flutter_instagram_clone/resources/pickImageController.dart';
import 'package:flutter_instagram_clone/utils/call_utilities.dart';
import 'package:flutter_instagram_clone/utils/utilities.dart';
// import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
import '../provider/image_upload_provider.dart';

class Chat extends StatefulWidget {
  _ChatState createState() => _ChatState();

  final String receiverid;
  final String roomId;
  final String username;
  final String fullName;
  final String image;
  final Usermodel receiver;
  Chat(
      {this.username,
      this.fullName,
      this.image,
      this.receiverid,
      this.roomId,
      this.receiver});
}

enum Send { Unsend, Copy, Save, Like }
enum Receive { Report, Copy, Like }

class _ChatState extends State<Chat> {
  // TabController _tabController;
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();
  FocusNode textFieldFocus = FocusNode();

  FirebaseRepository _repository = FirebaseRepository();
  CollectionReference messages = FirebaseFirestore.instance.collection("rooms");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> listMessage = List.from([]);

  FirebaseAuth _auth = FirebaseAuth.instance;
  Usermodel sender;
  Usermodel receiver;
  String _currentUserId;

  // bool isShowSticker = true;
  ImageUploadProvider _imageUploadProvider;
  final ScrollController listScrollController = ScrollController();
  // int _limit = 20;
  // final int _limitIncrement = 20;
  final FocusNode focusNode = FocusNode();
  final bool screenopened = true;
  bool isTexted = false;
  bool showEmojiPicker = false;
  _scrollListener() {}

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    listScrollController.addListener(_scrollListener);
    _repository.getCurrentUser().then((user) {
      _currentUserId = user.uid;
      _repository.getCurrentUserDetailsofuid(uid: user.uid).then((currentuser) {
        sender = currentuser;
        _repository
            .getCurrentUserDetailsofuid(uid: widget.receiverid)
            .then((otheruser) {
          receiver = otheruser;
        });
      });
    });
    firebaseMethods.readMessages(
        roomId: widget.roomId, currentuser: _auth.currentUser.uid);
    firebaseMethods.getroomshasunreadMessages(
        currentUser: _auth.currentUser.uid);
    firebaseMethods.seenStatus(
        otheruser: widget.receiverid, roomid: widget.roomId);
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        // isShowSticker = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    listScrollController.dispose();
    super.dispose();
  }

  showkeyboard() => textFieldFocus.requestFocus();
  hideKeyboard() => textFieldFocus.unfocus();

  hideEmojiContainer() {
    setState(() {
      setState(() {
        showEmojiPicker = false;
      });
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  Future<void> _receivedmessage(messageid) async {
    DocumentSnapshot message = await FirebaseFirestore.instance
        .collection("rooms")
        .doc(widget.roomId)
        .collection("messages")
        .doc(messageid)
        .get();
    switch (await showDialog<Receive>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                child: Text(
                  'Report',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context, Receive.Report);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: Text(
                  'Copy Text',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context, Receive.Copy);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: Text(
                  'Like',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context, Receive.Like);
                },
              )
            ],
          );
        })) {
      case Receive.Report:
        print("Captain Marvel Selection");
        break;
      case Receive.Copy:
        Clipboard.setData(ClipboardData(text: message.data()['message']));
        key.currentState
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text("the message copied")));
        break;
      case Receive.Like:
        print("Shazam selected");
        break;
    }
  }

  Future<void> _sentmessage(messageid) async {
    DocumentSnapshot message = await FirebaseFirestore.instance
        .collection("rooms")
        .doc(widget.roomId)
        .collection("messages")
        .doc(messageid)
        .get();
    print(message.data()['message']);
    switch (await showDialog<Send>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                child: Text(
                  'Unsend Message',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context, Send.Unsend);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: Text(
                  'Copy Text',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context, Send.Copy);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: Text(
                  'Save Quick Reply',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context, Send.Save);
                },
              ),
              SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: Text(
                  'Like',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pop(context, Send.Like);
                },
              )
            ],
          );
        })) {
      case Send.Unsend:
        try {
          await FirebaseFirestore.instance
              .collection("rooms")
              .doc(widget.roomId)
              .collection("messages")
              .doc(messageid)
              .delete();
        } catch (e) {
          print(e.toString());
        }
        await firebaseMethods.updateRoomMessage(
            currentUser: _auth.currentUser.uid,
            receiverId: widget.receiverid,
            roomId: widget.roomId);
        break;
      case Send.Copy:
        Clipboard.setData(ClipboardData(text: message.data()['message']));
        key.currentState
            .showSnackBar(SnackBar(content: Text("the message copied")));
        break;
      case Send.Save:
        print("save");
        break;
      case Send.Like:
        print("like");
        break;
    }
  }

  getMessage(Message message) {
    return message.type != MESSAGE_TYPE_IMAGE
        ? Text(
            message.message,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          )
        : message.photourl != null
            ? _imageMessage(message.photourl)
            : Text("Url was null");
  }

  // check whether the left message is the last one
  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()["senderId"] != widget.receiverid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
  // bool isLastMessageLeft(int index) {
  //   if (index + 1 == listMessage.length) {
  //     return true;
  //   }

  //   if ((index >= 0 &&
  //       listMessage != null &&
  //       listMessage[index + 1].data()["senderId"] == _auth.currentUser.uid)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()["senderId"] !=
                _auth.currentUser.uid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  // sent message
  sentMessage(index, Message message, messageid) {
    return GestureDetector(
        onLongPress: () {
          _sentmessage(messageid);
        },
        onDoubleTap: () async {
          DocumentReference documentReference =
              messages.doc(widget.roomId).collection("messages").doc(messageid);
          DocumentSnapshot snapshot = await documentReference.get();
          if (snapshot.data()['liked']) {
            await documentReference.update({
              "liked": false,
            });
          } else {
            await documentReference.update({"liked": true});
          }
        },
        child: StreamBuilder<DocumentSnapshot>(
          stream: messages
              .doc(widget.roomId)
              .collection("messages")
              .doc(messageid)
              .snapshots(),
          builder: (context, snapshot) => (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data.data() != null)
              ? snapshot.data.data()['liked']
                  ? Container(
                      // margin: EdgeInsets.only(bottom: 10),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 3.0 : 3.0,
                          right: 10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(top: 12, left: 6),
                              margin: snapshot.data.data()['type'] == 'text'
                                  ? EdgeInsets.only(right: 6)
                                  : EdgeInsets.only(right: 11),
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.65),
                              decoration: BoxDecoration(
                                color: snapshot.data.data()['type'] == "text"
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                    bottomRight: Radius.circular(18),
                                    bottomLeft: Radius.circular(18)),
                              ),
                              //
                              child: Padding(
                                  padding:
                                      snapshot.data.data()['type'] == 'text'
                                          ? EdgeInsets.all(10)
                                          : EdgeInsets.all(3),
                                  child: getMessage(message)),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.65),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 18),
                                    height: 10,
                                    width: 10,
                                    child: Icon(
                                      FontAwesome.heart,
                                      color: Colors.red,
                                    ),
                                  ),
                                  snapshot.data.data()['seen']
                                      ? Container(
                                          child: Text(
                                          "Seen",
                                          style: TextStyle(
                                              color: Colors.grey[400]),
                                        ))
                                      : SizedBox(
                                          width: 1,
                                          height: 1,
                                        )
                                ],
                              ),
                            )
                          ]),
                    )
                  : Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                // bottom: isLastMessageRight(index) ? 3.0 : 3.0,
                                right: 10.0),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.65),
                            decoration: BoxDecoration(
                              color: snapshot.data.data()['type'] == "text"
                                  ? Colors.grey[400]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                  bottomRight: Radius.circular(18),
                                  bottomLeft: Radius.circular(18)),
                            ),
                            child: Padding(
                                padding: snapshot.data.data()['type'] == 'text'
                                    ? EdgeInsets.all(10)
                                    : EdgeInsets.all(3),
                                child: getMessage(message))),
                        snapshot.data.data()['seen']
                            ? Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  "Seen",
                                  style: TextStyle(color: Colors.grey[600]),
                                ))
                            : SizedBox(
                                height: 1.0,
                              )
                      ],
                    )
              : Text(''),
        ));
  }

  // receiveed message
  receiveMessage(index, message, messageid) {
    return GestureDetector(
        onLongPress: () {
          _receivedmessage(messageid);
        },
        onDoubleTap: () async {
          DocumentReference documentReference =
              messages.doc(widget.roomId).collection("messages").doc(messageid);
          DocumentSnapshot snapshot = await documentReference.get();
          if (snapshot.data()['liked']) {
            await documentReference.update({
              "liked": false,
            });
          } else {
            await documentReference.update({"liked": true});
          }
        },
        child: StreamBuilder<DocumentSnapshot>(
          stream: messages
              .doc(widget.roomId)
              .collection("messages")
              .doc(messageid)
              .snapshots(),
          builder: (context, snapshot) => snapshot.hasData &&
                  snapshot.data != null
              ? snapshot.data.data()['liked']
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          isLastMessageLeft(index)
                              ? Material(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.0,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                themeColor),
                                      ),
                                      width: 35.0,
                                      height: 35.0,
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                    imageUrl: widget.image,
                                    width: 35.0,
                                    height: 35.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                )
                              : Container(
                                  width: 35.0,
                                  margin: EdgeInsets.only(right: 10.0),
                                  // color: Colors.red,
                                ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 12, left: 6),
                                  margin: snapshot.data.data()['type'] == 'text'
                                      ? EdgeInsets.only(left: 6)
                                      : EdgeInsets.only(left: 11),
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.65),
                                  decoration: BoxDecoration(
                                      color:
                                          snapshot.data.data()['type'] == "text"
                                              ? Colors.white
                                              : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          topRight: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                          bottomLeft: Radius.circular(18)),
                                      border: Border.all(
                                          width: 1, color: Colors.grey)),
                                  //
                                  child: Padding(
                                      padding:
                                          snapshot.data.data()['type'] == 'text'
                                              ? EdgeInsets.all(10)
                                              : EdgeInsets.all(3),
                                      child: getMessage(message)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  height: 10,
                                  width: 10,
                                  child: Icon(
                                    FontAwesome.heart,
                                    color: Colors.red,
                                  ),
                                )
                              ]),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        isLastMessageLeft(index)
                            ? Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Material(
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => Container(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.0,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                themeColor),
                                      ),
                                      width: 35.0,
                                      height: 35.0,
                                      padding: EdgeInsets.all(10.0),
                                    ),
                                    imageUrl: widget.image,
                                    width: 35.0,
                                    height: 35.0,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                              )
                            : Container(
                                width: 35.0,
                                margin: EdgeInsets.only(right: 10.0),
                              ),
                        Container(
                            // margin: EdgeInsets.only(top: 12, right: 6),
                            margin: snapshot.data.data()['type'] == 'text'
                                ? EdgeInsets.only(left: 6)
                                : EdgeInsets.only(left: 11),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.65),
                            decoration: BoxDecoration(
                                color: snapshot.data.data()['type'] == "text"
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                    bottomRight: Radius.circular(18),
                                    bottomLeft: Radius.circular(18)),
                                border: snapshot.data.data()['type'] == 'text'
                                    ? Border.all(width: 1, color: Colors.grey)
                                    : Border.all(width: 0, color: Colors.grey)),
                            child: Padding(
                                padding: snapshot.data.data()['type'] == 'text'
                                    ? EdgeInsets.all(10)
                                    : EdgeInsets.all(3),
                                child: getMessage(message))),
                      ],
                    )
              : Text(''),
        ));
  }

  Widget _imageMessage(imageurl) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullPhoto(url: imageurl)));
            },
            child: CachedNetworkImage(
              imageUrl: imageurl,
              placeholder: (context, url) => Container(
                transform: Matrix4.translationValues(0, 0, 0),
                child: Container(
                  width: 60,
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // the message item
  Widget chatMessageItem(int index, DocumentSnapshot snapshot) {
    Message _message = Message.fromMap(snapshot.data());

    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Container(
        alignment: _message.senderId == _currentUserId
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: _message.senderId == _currentUserId
            ? sentMessage(index, _message, snapshot.id)
            : receiveMessage(index, _message, snapshot.id),
      ),
    );
  }

  Future<void> updateRoom(
      {@required String roomid,
      @required String message,
      @required String senderId,
      @required String receiverId,
      @required lastmessageId,
      @required lastmessagesenderId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(senderId)
        .collection("rooms")
        .doc(roomid)
        .update({
      "senderId": senderId,
      "lastmessageId": lastmessageId,
      "message": message,
      "time": FieldValue.serverTimestamp()
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("rooms")
        .doc(roomid)
        .update({
      "message": message,
      "senderId": senderId,
      "lastmessageId": lastmessageId,
      "time": FieldValue.serverTimestamp()
    });
  }

  @override
  Widget build(BuildContext context) {
    listMessage = [];
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProfile(
                          uid: widget.receiverid,
                        )));
          },
          child: StreamBuilder<DocumentSnapshot>(
            stream: users.doc(widget.receiverid).snapshots(),
            builder: (context, snapshot) =>
                snapshot.hasData && snapshot.data != null
                    ? Container(
                        child: Row(
                        children: [
                          snapshot.data.data()['state'] == 1
                              ? OnlinIndicatorChat(
                                  photourl: widget.image,
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(widget.image),
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 70,
                                  child: Text(
                                    widget.fullName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 70,
                                child: snapshot.data.data()['state'] == 1
                                    ? Text(
                                        "Active now",
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 11),
                                      )
                                    : Text(
                                        widget.username,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                              )
                            ],
                          )
                        ],
                      ))
                    : Text(""),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Feather.arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, 'Yes');
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Feather.video,
                color: Colors.black,
              ),
              // the current user will call other one
              onPressed: () async {
                await [
                  Permission.camera,
                  Permission.microphone,
                  Permission.storage
                ].request();
                CallUtils.dial(
                    from: sender,
                    to: receiver,
                    roomId: widget.roomId,
                    context: context);
              }),
          IconButton(
            icon: Icon(
              Feather.flag,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Feather.info,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: messages
              .doc(widget.roomId)
              .collection("messages")
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              listMessage = [];
              print("again");
              listMessage.addAll(snapshot.data.docs);
              firebaseMethods.readMessages(
                  roomId: widget.roomId, currentuser: _auth.currentUser.uid);
              firebaseMethods.seenStatus(
                  otheruser: widget.receiverid, roomid: widget.roomId);
              firebaseMethods.updateRoomMessage(
                  currentUser: _auth.currentUser.uid,
                  roomId: widget.roomId,
                  receiverId: widget.receiverid);

              return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (snapshot.data.docs[index] != null &&
                                  snapshot.data.docs[index] != null) {
                                return chatMessageItem(
                                    index, snapshot.data.docs[index]);
                              }
                              return SizedBox(
                                height: 0,
                                width: 0,
                              );
                            },
                            itemCount: snapshot.data.docs.length,
                            reverse: true,
                            controller: listScrollController,
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        )),
                        StreamBuilder<DocumentSnapshot>(
                          stream: firestore
                              .collection("users")
                              .doc(widget.receiverid)
                              .snapshots(),
                          builder: (context, snap) {
                            if (snap.hasData && snap.data != null) {
                              bool isTyping = snap.data.data()['isTyping'];
                              if (isTyping) {
                                return Container(
                                  width: 108,
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        child: AvatarGlow(
                                          glowColor: Colors.grey[600],
                                          endRadius: 24,
                                          duration:
                                              Duration(milliseconds: 2000),
                                          repeat: true,
                                          showTwoGlows: true,
                                          repeatPauseDuration:
                                              Duration(milliseconds: 100),
                                          child: Material(
                                            elevation: 8.0,
                                            shape: CircleBorder(),
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundImage:
                                                  NetworkImage(widget.image),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "Typing....",
                                            style: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return SizedBox(
                                height: 0.5,
                              );
                            }
                            return SizedBox(
                              height: 0.5,
                            );
                          },
                        ),
                        // buildInput()
                        MessageInput(
                          roomId: widget.roomId,
                          receiverid: widget.receiverid,
                        )
                      ]));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
