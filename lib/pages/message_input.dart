import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/resources/firebaseController.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:flutter_instagram_clone/resources/pickImageController.dart';

class MessageInput extends StatefulWidget {
  final String roomId;
  final String receiverid;
  MessageInput({this.roomId, this.receiverid});
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool isTexted = false;
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 80,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: Container(
            // height: 80,
            padding: isTexted
                ? EdgeInsets.only(left: 10, top: 6, bottom: 6)
                : EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid, width: 1, color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isTexted
                    ? Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.purple,
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                            icon: Icon(
                              Feather.camera,
                              color: Colors.white,
                            ),
                            iconSize: 14,
                            onPressed: () {},
                          ),
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40)),
                        child: IconButton(
                          icon: Icon(
                            Feather.camera,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Form(
                      key: _formKey,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _controller,
                        onFieldSubmitted: (value) {
                          print(value);
                        },
                        maxLines: 5,
                        minLines: 1,
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        decoration:
                            InputDecoration.collapsed(hintText: 'Message...'),
                        onChanged: (value) async {
                          await firebaseMethods.isTyping(
                              query: value, uid: _auth.currentUser.uid);
                          if (value.length > 0 && value.trim() != "") {
                            setState(() {
                              isTexted = true;
                            });
                          } else if (value.length == 0) {
                            setState(() {
                              isTexted = false;
                            });
                          }
                        },
                        validator: (value) {
                          if (value.isEmpty) {}
                          return null;
                        },
                      )),
                ),
                Container(
                    child: !isTexted
                        ? Row(children: [
                            IconButton(
                              icon: Icon(
                                Feather.mic,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                AntDesign.picture,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                PickImageController.instance
                                    .cropImageFromFile()
                                    .then((croppedfile) {
                                  if (croppedfile != null) {
                                    _saveUserImageToFireStorage(croppedfile);
                                  } else {
                                    _showDialog('Pick Image error');
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                AntDesign.pluscircle,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ])
                        : GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.blue[400],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            onTap: () {
                              sendMessage(
                                  content: _controller.text.trim(),
                                  type: "text");
                            },
                          ))
              ],
            )));
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

  Future<void> _saveUserImageToFireStorage(croppedFile) async {
    try {
      String takeImageURL = await FirebaseController.instance
          .sendImageToUserInChatRoom(croppedFile, widget.roomId);
      _handleSubmitted(takeImageURL);
    } catch (e) {
      _showDialog('Error add user image to storage');
    }
  }

  Future<void> _handleSubmitted(imageurl) async {
    try {
      DocumentReference message = await FirebaseFirestore.instance
          .collection("rooms")
          .doc(widget.roomId)
          .collection("messages")
          .add({
        "liked": false,
        "senderId": _auth.currentUser.uid,
        "message": "Image",
        "type": "image",
        "photourl": imageurl,
        "time": DateTime.now().millisecondsSinceEpoch.toString()
      });
      await firebaseMethods.saveLastmessageofcurrentUser(
          lastmessageid: message.id);
      await updateRoom(
          roomid: widget.roomId,
          message: "Image",
          senderId: _auth.currentUser.uid,
          receiverId: widget.receiverid,
          lastmessageId: message.id,
          lastmessagesenderId: _auth.currentUser.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  _showDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
          );
        });
  }

  sendMessage({String content, String type}) async {
    try {
      if (content.trim() != null) {
        _controller.clear();

        await firebaseMethods.isTyping(
            query: _controller.text.trim(), uid: _auth.currentUser.uid);

        DocumentReference message = await FirebaseFirestore.instance
            .collection("rooms")
            .doc(widget.roomId)
            .collection("messages")
            .add({
          "senderId": _auth.currentUser.uid,
          "time": FieldValue.serverTimestamp(),
          "message": content,
          "type": type,
          "seen": false,
          "unread": true,
          "liked": false,
        });

        setState(() {
          isTexted = false;
        });

        await updateRoom(
            roomid: widget.roomId,
            message: content,
            senderId: _auth.currentUser.uid,
            receiverId: widget.receiverid,
            lastmessageId: message.id,
            lastmessagesenderId: _auth.currentUser.uid);
        await firebaseMethods.makeMessagesUnseen(roomId: widget.roomId);
        await firebaseMethods.sendgetroomshasunreadMessages(
            currentUser: _auth.currentUser.uid);
        await firebaseMethods.saveLastmessageofcurrentUser(
            lastmessageid: message.id, currentUser: _auth.currentUser.uid);
        // await firebaseMethods.seenStatus(
        //     roomid: widget.roomId, otheruser: widget.receiverid);

      }
    } catch (e) {
      print(e.toString());
    }
  }
}
