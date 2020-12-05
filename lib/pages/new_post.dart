import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/activity_screen.dart';

import 'package:flutter_instagram_clone/pages/select_location.dart';

class NewPost extends StatefulWidget {
  final File photourl;
  NewPost({this.photourl});
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _caption = TextEditingController();
  bool _facebook = false;
  bool _twitter = false;
  bool _thumblr = false;
  String location = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'New Post',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(Feather.arrow_left, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Activity(
              //               image: widget.photourl,
              //               caption: _caption.text.trim(),
              //             )));
            },
            child: Container(
              margin: EdgeInsets.only(left: 6),
              width: 100,
              // color: Colors.red,
              alignment: Alignment.center,
              child: Text('Share',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 60,
                      height: 60,
                      child: widget.photourl != null
                          ? Image.file(widget.photourl)
                          : Image(
                              image: AssetImage("assets/images/avatar1.png"),
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                          child: TextField(
                        cursorColor: Colors.black,
                        controller: _caption,
                        textAlignVertical: TextAlignVertical.center,
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration.collapsed(
                            hintText: "Write a caption...",
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      )),
                    )
                  ],
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  child: Text("Tag People",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                  child: Text("Tag Businees Partner",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                Divider(),
                GestureDetector(
                  onTap: () async {
                    // dynamic result = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SelectLocation()));

                    // print("results is $result");
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                      child: Text("Add Location",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold))),
                ),
                Divider(),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                    child: Text("Also post to",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Facebook",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Switch(
                                value: _facebook,
                                onChanged: (bool newvalue) {
                                  setState(() {
                                    _facebook = newvalue;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                            "Twitter",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                          Switch(
                              value: _twitter,
                              onChanged: (bool newvalue) {
                                setState(() {
                                  _twitter = newvalue;
                                });
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text("Thumblr",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                          Switch(
                              value: _thumblr,
                              onChanged: (bool newvalue) {
                                setState(() {
                                  _thumblr = newvalue;
                                });
                              })
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 30),
                  child: Text("Advanced Settings",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
