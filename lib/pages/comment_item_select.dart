import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram_clone/pages/other_comment.dart';
import 'package:flutter_instagram_clone/pages/reply.dart';
import 'package:flutter_instagram_clone/pages/user_comnnet.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentItem extends StatefulWidget {
  final String userid; // user who commented on the post
  final String comment;
  final String postid;
  final String posttime;
  final String time;
  final int replies;
  final String uploaderid;
  final String commentid;
  final String caption;
  final List<dynamic> likes;
  final bool pressed;
  final void Function(String whom)
      itIsReply; // to decide if it is simple comment

  CommentItem(
      {this.commentid,
      this.postid,
      this.userid,
      this.comment,
      this.likes,
      this.time,
      this.uploaderid,
      this.replies,
      this.itIsReply,
      this.pressed,
      this.caption,
      this.posttime});
  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem>
    with SingleTickerProviderStateMixin {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  Animation _curve;
  bool isFav = false;
  List<QueryDocumentSnapshot> replieslist = [];
  LongPressGestureRecognizer _longPressGestureRecognizer;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _curve = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
    _colorAnimation =
        Tween(begin: Colors.grey[500], end: Colors.red).animate(_curve);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 10, end: 13), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 13, end: 10), weight: 50)
    ]).animate(_curve);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
    firebaseMethods
        .retriveAllReplies(postId: widget.postid, commentId: widget.commentid)
        .then((replies) {
      setState(() {
        replieslist = replies;
      });
    });
    _longPressGestureRecognizer = LongPressGestureRecognizer()
      ..onLongPress = _handlePress;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _longPressGestureRecognizer.dispose();
  }

  void _handlePress() {
    HapticFeedback.vibrate();
  }

  @override
  Widget build(BuildContext context) {
    isFav = widget.likes.contains(_auth.currentUser.uid);

    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.collection("users").doc(widget.userid).snapshots(),
      builder: (context, snapshot) => (snapshot.hasData &&
              snapshot.data != null)
          ? Column(
              children: [
                GestureDetector(
                  onLongPress: () {
                    if (widget.userid == _auth.currentUser.uid) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserComment(
                                    caption: widget.caption,
                                    uploaderId: widget.uploaderid,
                                    time: widget.posttime,
                                    postId: widget.postid,
                                    pressedcommentid: widget.commentid,
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherComment(
                                    caption: widget.caption,
                                    uploaderId: widget.uploaderid,
                                    time: widget.posttime,
                                    postId: widget.postid,
                                    pressedcommentid: widget.commentid,
                                  )));
                    }
                    widget.itIsReply("abdelali is me");
                  },
                  onTap: () {
                    // show the toast here
                    Fluttertoast.showToast(
                        msg: "you can only choose 1 comment at a time",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.6),
                        textColor: Colors.white,
                        fontSize: 14.0);
                  },
                  child: Container(
                    color:
                        widget.pressed ? Colors.blue[100] : Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    margin: EdgeInsets.symmetric(vertical: 2),
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  // color: Colors.red,
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: RichText(
                                      softWrap: true,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: snapshot.data
                                                .data()['username'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: " ${widget.comment}",
                                            style:
                                                TextStyle(color: Colors.black))
                                      ])),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "${widget.time}   ",
                                            style: TextStyle(
                                                color: Colors.grey[500])),
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
                                        replieslist.length > 0
                                            ? (TextSpan(
                                                text: "${replieslist.length}",
                                                style: TextStyle(
                                                    color: Colors.grey[500])))
                                            : TextSpan(text: ""),
                                        TextSpan(
                                            recognizer:
                                                _longPressGestureRecognizer,
                                            text: " reply",
                                            style: TextStyle(
                                                color: Colors.grey[500]))
                                      ]))
                                    ]),
                              ]),

                          //
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        IconButton(
                          icon: isFav
                              ? Icon(
                                  Icons.favorite,
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

                            firebaseMethods.likeComment(
                                postId: widget.postid,
                                uploaderId: widget.uploaderid,
                                userId: _auth.currentUser.uid,
                                commentId: widget.commentid);
                          },
                          iconSize: 15,
                        )
                      ],
                    ),
                  ),
                ),
                Reply(
                  commentId: widget.commentid,
                  postId: widget.postid,
                )
              ],
            )
          : SizedBox(
              height: 0,
            ),
    );
  }
}
