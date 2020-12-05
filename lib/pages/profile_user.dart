import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_instagram_clone/badges/Instahome.dart';
// import 'package:flutter_instagram_clone/badges/comments.dart';

import 'package:flutter_instagram_clone/pages/followers.dart';
import 'package:flutter_instagram_clone/pages/following_items.dart';
import 'package:flutter_instagram_clone/pages/highlight_item.dart';
import 'package:flutter_instagram_clone/pages/story.dart';
import 'package:flutter_instagram_clone/stories/data.dart';
import 'package:flutter_instagram_clone/stories/models/user_model.dart';
import 'package:flutter_instagram_clone/stories/stories.dart';
// import 'package:flutter_instagram_clone/badges/posts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfile extends StatefulWidget {
  final String uid;
  UserProfile({this.uid});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  CollectionReference user = FirebaseFirestore.instance.collection("users");
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference blobs = FirebaseFirestore.instance.collection("blobs");

  List<int> list = List.generate(30, (index) => index + 1);
  ScrollController _controller;
  ScrollController _scrollController;

  CollectionReference users = FirebaseFirestore.instance.collection("users");
  bool rechedtop = false;
  _scrollLitener() {
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      // print('the grid view stop');
      setState(() {
        rechedtop = true;
      });
    }
  }

  _scrollContolViewListener() {
    // print('the grid view work ${_scrollController.position.pixels}');
    if (_scrollController.position.pixels >= 470) {
      setState(() {
        rechedtop = false;
      });
    }
  }

  void initState() {
    _controller = ScrollController();
    _scrollController = ScrollController();
    _controller.addListener(_scrollLitener);
    _scrollController.addListener(_scrollContolViewListener);
    super.initState();
  }

  List<Story> _stories = [
    Story(
        "https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/936229/pexels-photo-936229.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/1097456/pexels-photo-1097456.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/1124724/pexels-photo-1124724.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/573299/pexels-photo-573299.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/756453/pexels-photo-756453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/937481/pexels-photo-937481.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/412840/pexels-photo-412840.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        "abdelali.codes")
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: users.doc(widget.uid).snapshots(),
        builder: (context, snapshot) => snapshot.hasData
            ? DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 1,
                    backgroundColor: Colors.white,
                    title: Container(
                      child: Row(
                        children: [
                          Text(
                            snapshot.data.data()['username'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        Feather.arrow_left,
                        color: Colors.black,
                        // size: 40,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: Container(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: users.doc(widget.uid).snapshots(),
                          builder: (context, snapshot) => snapshot.hasData
                              ? Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      style: BorderStyle
                                                                          .solid,
                                                                      color: Colors
                                                                              .grey[
                                                                          400],
                                                                      width: 1,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            80)),
                                                            child: Container(
                                                              width: 80,
                                                              height: 80,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            80),
                                                                child: snapshot
                                                                        .hasData
                                                                    ? Image(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(snapshot
                                                                            .data
                                                                            .data()['photourl']),
                                                                      )
                                                                    : Text(""),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    Expanded(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text("20",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                              "posts",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Followers()));
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Text("260",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                "followers",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Followers()));
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Text("1200",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                "following",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                                  ],
                                                )),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              // color: Colors.blue,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "fullStack developper ❤❤",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                  Text(
                                                    "Digital Creator",
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                  Text(
                                                    "I am big data ❤💙💙",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "I am big data 💕💕💕",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "I am big data 🎁🎁",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "I am big data 😜😜",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FollowingItems(
                                              followers: snapshot.data
                                                  .data()["followers"],
                                              userid: widget.uid,
                                            ),

                                            // the highlights
                                            Container(
                                              // margin: EdgeInsets.only(top: 16),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2),

                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Row(
                                                    children: [
                                                      Row(
                                                          children:
                                                              List.generate(
                                                                  _stories
                                                                      .length,
                                                                  (index) {
                                                        return GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                              return StoryScreen(
                                                                stories:
                                                                    stories,
                                                                user: UserStory(
                                                                    name: _stories[
                                                                            index]
                                                                        .name,
                                                                    profileImageUrl:
                                                                        _stories[index]
                                                                            .image),
                                                              );
                                                            }));
                                                          },
                                                          child: HighLightItem(
                                                            img: _stories[index]
                                                                .image,
                                                            name:
                                                                _stories[index]
                                                                    .name,
                                                          ),
                                                        );
                                                      }))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                        child: AppBar(
                                          backgroundColor: Colors.white,
                                          bottom: TabBar(
                                            labelColor: Colors.black,
                                            indicatorColor: Colors.black,
                                            unselectedLabelColor:
                                                Colors.grey[500],
                                            tabs: [
                                              Tab(
                                                icon: Icon(AntDesign.table),
                                              ),
                                              Tab(
                                                icon: Icon(
                                                  MaterialIcons.live_tv,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 462,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.grey,
                                        child: TabBarView(children: [
                                          Container(
                                              color: Colors.white,
                                              child: GridView.count(
                                                controller: _controller,
                                                physics: rechedtop
                                                    ? NeverScrollableScrollPhysics()
                                                    : null,
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 2,
                                                mainAxisSpacing: 2,
                                                children: list.map((e) {
                                                  return Container(
                                                    child: Image(
                                                      image: AssetImage(
                                                          "assets/images/avatar1.png"),
                                                    ),
                                                  );
                                                }).toList(),
                                              )),
                                          Container(
                                            color: Colors.white,
                                            child: Center(
                                              child: Text(
                                                'Bike',
                                              ),
                                            ),
                                          ),

                                          // second tab bar viiew widget
                                        ]),
                                      ),
                                    ],
                                  ),
                                )
                              : CircularProgressIndicator()),
                    ),
                  ),
                ),
              )
            : Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
  }
}
