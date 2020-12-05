import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/comments.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:flutter_instagram_clone/utils/comment_sheetbuttom.dart';

class PostItem extends StatefulWidget {
  final String postid;
  final String caption;
  final String uploaderId;
  final String postphoto;
  final String time;
  final List<dynamic> savelist;
  final List<dynamic> likelist;

  PostItem({
    this.postid,
    this.caption,
    this.uploaderId,
    this.time,
    this.postphoto,
    this.savelist,
    this.likelist,
  });
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with TickerProviderStateMixin {
  bool isdoubleclicked = false;
  bool isliked = false;
  bool issaved = false;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  AnimationController _savepost;
  Animation _curve;
  List<QueryDocumentSnapshot> comments = [];
  List<QueryDocumentSnapshot> commentsofusers = [];
  bool savepost = false;

  @override
  void initState() {
    super.initState();
    // the heart animation
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _colorAnimation =
        ColorTween(begin: Colors.grey[400], end: Colors.red).animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 25, end: 28), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 28, end: 25), weight: 50)
    ]).animate(_curve);
    _savepost = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), value: 1.0);
    _savepost.addListener(() {
      setState(() {});
    });
    _savepost.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            savepost = false;
          });
        });
      }
      // }
      // if (status == AnimationStatus.dismissed) {
      //   setState(() {
      //     savepost = false;
      //   });
      // }
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isliked = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isliked = false;
        });
      }
    });

    firebaseMethods.getAllCommentOfPost(postid: widget.postid).then((data) {
      // print(" the comments length is ${comments.length}");
      comments = data;
    });

    firebaseMethods
        .getAllFollowedUsers(currentUser: _auth.currentUser.uid)
        .then((following) {
      firebaseMethods
          .getAllCommentoffollwedUsers(postid: widget.postid, users: following)
          .then((userscomments) {
        commentsofusers = userscomments;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _savepost.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    isliked = widget.likelist.contains(_auth.currentUser.uid);
    issaved = widget.savelist.contains(_auth.currentUser.uid);
    if (isliked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return StreamBuilder<DocumentSnapshot>(
        stream: users.doc(widget.uploaderId).snapshots(),
        builder: (context, snapshotdoc) {
          if (snapshotdoc.hasData && snapshotdoc.data != null) {
            return Container(
              // width: 200,
              // height: 200,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image(
                                image: NetworkImage(
                                    snapshotdoc.data.data()['photourl']),
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              snapshotdoc.data.data()['username'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        IconButton(
                          icon: Icon(Feather.more_vertical),
                          onPressed: () {
                            onPressMoreButton(context);
                          },
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        isdoubleclicked = true;
                      });
                    },
                    child: Stack(
                      // alignment: Alignment.center,
                      children: [
                        Container(
                          // height: 200,
                          child: InteractiveViewer(
                            minScale: 1.0,
                            maxScale: 6.0,
                            child: FadeInImage.assetNetwork(
                              image: widget.postphoto,
                              placeholder: "assets/images/spinner.gif",
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          bottom: savepost ? 0 : -40,
                          left: 0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(right: 10),
                            height: 40,
                            width: size.width,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 30,
                                          child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/images/spinner.gif",
                                              image: widget.postphoto,
                                              fit: BoxFit.cover),
                                        ),
                                        Text("Saved",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Save to collection",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, _) => IconButton(
                              onPressed: () {
                                setState(() {
                                  isliked
                                      ? _controller.reverse()
                                      : _controller.forward();
                                });
                                firebaseMethods.likedPost(
                                    postid: widget.postid,
                                    uploaderid: widget.uploaderId,
                                    userid: _auth.currentUser.uid);
                              },
                              icon: isliked
                                  ? Icon(
                                      Icons.favorite,
                                      color: _colorAnimation.value,
                                      size: _sizeAnimation.value,
                                    )
                                  : Icon(
                                      Feather.heart,
                                      color: Colors.black,
                                      size: _sizeAnimation.value,
                                    ),
                              color: isliked ? Colors.red : Colors.black,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Comment(
                                              postId: widget.postid,
                                              uploaderId: widget.uploaderId,
                                              caption: widget.caption,
                                              time: widget.time,
                                            )));
                              },
                              icon: Icon(FontAwesome.comment_o)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Feather.send),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (!issaved) {
                            print("forward the animation");
                            setState(() {
                              savepost = true;
                            });
                            _savepost.forward();
                          }
                          setState(() {
                            issaved = !issaved;
                          });
                          firebaseMethods.savePost(
                              postid: widget.postid,
                              uploaderid: widget.uploaderId,
                              userid: _auth.currentUser.uid);
                        },
                        icon: Icon(
                            issaved ? FontAwesome.bookmark : Feather.bookmark),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    child: RichText(
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "${widget.likelist.length} Likes",
                          style: TextStyle(color: Colors.black),
                        ),
                        // TextSpan(
                        //   text: "Sigmund,",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.black),
                        // ),
                        // TextSpan(
                        //   text: " Yessenia,",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.black),
                        // ),
                        // TextSpan(
                        //   text: " Dayana",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.black),
                        // ),
                        // TextSpan(
                        //   text: " and",
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // TextSpan(
                        //   text: " 1263 others",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.black),
                        // ),
                      ]),
                    ),
                  ),

                  // caption
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    child: RichText(
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: snapshotdoc.data.data()['username'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: " ${widget.caption}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // view all comments
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Comment(
                                      postId: widget.postid,
                                      uploaderId: widget.uploaderId,
                                    )));
                      },
                      child: comments.length >= 1
                          ? (Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "View all ${comments.length} comments",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                          : SizedBox(
                              height: 0,
                            )),

                  // the first and second comment
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  //   child: RichText(
                  //     maxLines: 2,
                  //     softWrap: true,
                  //     overflow: TextOverflow.ellipsis,
                  //     text: TextSpan(
                  //       children: [
                  //         TextSpan(
                  //           text: snapshotdoc.data.data()['username'],
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black),
                  //         ),
                  //         TextSpan(
                  //           text: " ${widget.caption}",
                  //           style: TextStyle(color: Colors.black),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // the second comment
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   margin: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  //   child: RichText(
                  //     maxLines: 2,
                  //     softWrap: true,
                  //     overflow: TextOverflow.ellipsis,
                  //     text: TextSpan(
                  //       children: [
                  //         TextSpan(
                  //           text: snapshotdoc.data.data()['username'],
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.black),
                  //         ),
                  //         TextSpan(
                  //           text: " ${widget.caption}",
                  //           style: TextStyle(color: Colors.black),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 6),
                  // post date
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${widget.time}",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            );
          }
          return Text("");
          // return Center(
          //     child: CircularProgressIndicator(
          //         strokeWidth: 1.0,
          //         valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500])));
        });
  }
}

// PopupMenuButton<String>(
//   icon: Icon(Icons.more_vert),
//   onSelected: (String result) {
//     // setState(() {
//     //   _selection = result;
//     // });
//     print(result);
//   },
//   itemBuilder:
//       (BuildContext context) =>
//           <PopupMenuEntry<String>>[
//     const PopupMenuItem<String>(
//       value: "Woring",
//       child: Text('Working'),
//     ),
//     const PopupMenuItem<String>(
//       value: "Workin",
//       child: Text('Being'),
//     ),
//     const PopupMenuItem<String>(
//       value: "Being",
//       child: Text('Being'),
//     ),
//     const PopupMenuItem<String>(
//       value: "Placed",
//       child: Text('Placed'),
//     ),
//   ],
// )
