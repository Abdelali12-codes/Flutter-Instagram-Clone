import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';

class ReplayItem extends StatefulWidget {
  final String commentid;
  final String postid;
  final String replyid;
  final String uploaderid;
  final String userid;
  final String comment;
  final String time;
  final String taged;
  final List<dynamic> likes;
  ReplayItem(
      {this.replyid,
      this.postid,
      this.commentid,
      this.uploaderid,
      this.userid,
      this.comment,
      this.time,
      this.likes,
      this.taged});
  @override
  _ReplayItemState createState() => _ReplayItemState();
}

class _ReplayItemState extends State<ReplayItem> {
  bool isFav = false;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    isFav = widget.likes.contains(_auth.currentUser.uid);
    return StreamBuilder<DocumentSnapshot>(
        stream: firestore.collection("users").doc(widget.userid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Container(
              // color: Colors.red,

              padding: EdgeInsets.symmetric(horizontal: 6),
              margin: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 36,
                        width: 36,

                        padding: EdgeInsets.all(1),
                        alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     border: Border.all(width: 2, color: Colors.red)),
                        child: Container(
                          height: 36,
                          width: 36,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              image: snapshot.data.data()['photourl'],
                              placeholder: "assets/images/spinner.gif",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: 210,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(vertical: 5),

                            // width: MediaQuery.of(context).size.width * 0.50,
                            child: RichText(
                                softWrap: true,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: snapshot.data.data()['username'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: " ${widget.taged}",
                                      style:
                                          TextStyle(color: Colors.blue[400])),
                                  TextSpan(
                                      text: " ${widget.comment}",
                                      style: TextStyle(color: Colors.black))
                                ])),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "${widget.time}   ",
                                      style:
                                          TextStyle(color: Colors.grey[500])),
                                  widget.likes.length >= 1
                                      ? TextSpan(
                                          text: '${widget.likes.length}',
                                          style: TextStyle(
                                              color: Colors.grey[500]))
                                      : TextSpan(text: ""),
                                  widget.likes.length >= 1
                                      ? TextSpan(
                                          text: "likes    ",
                                          style: TextStyle(
                                              color: Colors.grey[500]))
                                      : TextSpan(text: ""),
                                  TextSpan(
                                      text: "reply",
                                      style: TextStyle(color: Colors.grey[500]))
                                ]))
                              ]),
                        ]),

                    //
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: isFav
                        ? Icon(
                            Icons.favorite,
                            // color: _colorAnimation.value,
                            // size: _sizeAnimation.value,
                            size: 12,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.grey[500],
                            size: 12,
                          ),
                    onPressed: () {
                      // isFav ? _controller.reverse() : _controller.forward();
                      setState(() {
                        isFav = !isFav;
                      });

                      firebaseMethods.likeReply(
                          postid: widget.postid,
                          uploaderid: widget.uploaderid,
                          userid: _auth.currentUser.uid,
                          commentid: widget.commentid,
                          replyid: widget.replyid);
                    },
                    iconSize: 15,
                  )
                ],
              ),
            );
          }
          return SizedBox(
            height: 0,
          );
        });
  }
}
