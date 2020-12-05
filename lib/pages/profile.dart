import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/constants.dart';
import 'package:flutter_instagram_clone/pages/edit_profile.dart';
import 'package:flutter_instagram_clone/pages/followers.dart';
import 'package:flutter_instagram_clone/pages/highlight_item.dart';
import 'package:flutter_instagram_clone/pages/story.dart';
import 'package:flutter_instagram_clone/pages/story_item.dart';
import 'package:flutter_instagram_clone/pages/user_posts.dart';
import 'package:flutter_instagram_clone/stories/data.dart';
import 'package:flutter_instagram_clone/stories/models/user_model.dart';
import 'package:flutter_instagram_clone/stories/stories.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({this.uid});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              height: 900,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(children: [
                            SizedBox(height: 10),
                            Container(
                              width: 50,
                              height: 6,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Create New",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 2,
                    ),
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 6),
                                      child: IconButton(
                                        icon: Icon(Feather.video),
                                        onPressed: () {},
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Feed Post",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Colors.red,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 6),
                                      child: IconButton(
                                        icon: Icon(Feather.video),
                                        onPressed: () {},
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Story",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Divider(
                                        height: 2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 6),
                                      child: IconButton(
                                        icon: Icon(Feather.video),
                                        onPressed: () {},
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Story Highlight",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Divider(
                                        height: 2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 6),
                                      child: IconButton(
                                        icon: SvgPicture.asset(
                                            "assets/svg/instagram-igtv.svg"),
                                        onPressed: () {},
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "IGTV Video",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Divider(
                                        height: 2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 6),
                                      child: IconButton(
                                        icon: SvgPicture.asset(
                                            "assets/svg/instagram-reels.svg"),
                                        onPressed: () {},
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Reel",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      Divider(
                                        height: 2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ));
        });
  }

  void _onPressArrowButton(photourl, username) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF000000).withOpacity(0.55),
              // constraints: BoxConstraints(minHeight: 900),
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 6,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(photourl),
                      ),
                      title: Text(
                        username,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      trailing: Radio(
                        onChanged: (value) {},
                        groupValue: username,
                        value: username,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 60,
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.black)),
                      ),
                      title: Text("add Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ));
        });
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
      stream: users.doc(_auth.currentUser.uid).snapshots(),
      builder: (context, snapshot) => snapshot.hasData
          ? DefaultTabController(
              length: 3,
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
                        IconButton(
                          icon: Icon(MaterialIcons.keyboard_arrow_down),
                          onPressed: () {
                            _onPressArrowButton(
                                snapshot.data.data()['photourl'],
                                snapshot.data.data()['username']);
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 40,
                    ),
                    iconSize: 25,
                    onPressed: () {
                      _onButtonPressed();
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Feather.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                body: Container(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: StreamBuilder<DocumentSnapshot>(
                        stream: users.doc(_auth.currentUser.uid).snapshots(),
                        builder: (context, snapshot) => snapshot.hasData
                            ? Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 470,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          height: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    style: BorderStyle
                                                                        .solid,
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              80)),
                                                          child: Container(
                                                            width: 80,
                                                            height: 80,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          60),
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
                                                        Positioned(
                                                          bottom: 2,
                                                          right: -7,
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            // padding: EdgeInsets.all(3),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  AntDesign
                                                                      .pluscircle,
                                                                  color: Colors
                                                                          .blue[
                                                                      400]),
                                                              onPressed: () {
                                                                print(
                                                                    'helllllo');
                                                              },
                                                              iconSize: 20,
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                            ),
                                                          ),
                                                        )
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
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Posts()));
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Text("20",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
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
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                              "followers",
                                                              style: TextStyle(
                                                                  fontSize: 13,
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
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                              "following",
                                                              style: TextStyle(
                                                                  fontSize: 13,
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
                                                Text("fullStack developper ❤❤",
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
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 32,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1,
                                                          color:
                                                              Colors.grey[400]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: FlatButton(
                                                    child: Text('Edit Profile'),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditProfile()));
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  height: 32,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1,
                                                          color:
                                                              Colors.grey[400]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: FlatButton(
                                                    child: Text('Promotions'),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                Container(
                                                  height: 32,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1,
                                                          color:
                                                              Colors.grey[400]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  child: FlatButton(
                                                    child: Text('Insights'),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // the highlights
                                          Container(
                                            // margin: EdgeInsets.only(top: 16),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            // color: Colors.red,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20,
                                                        left: 15,
                                                        bottom: 10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 65,
                                                          height: 65,
                                                          child: Stack(
                                                            children: [
                                                              Container(
                                                                width: 65,
                                                                height: 65,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.add,
                                                                  size: 45,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .black),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Container(
                                                          width: 70,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "New",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                      children: List.generate(
                                                          _stories.length,
                                                          (index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return StoryScreen(
                                                            stories: stories,
                                                            user: UserStory(
                                                                name: _stories[
                                                                        index]
                                                                    .name,
                                                                profileImageUrl:
                                                                    _stories[
                                                                            index]
                                                                        .image),
                                                          );
                                                        }));
                                                      },
                                                      child: HighLightItem(
                                                        img: _stories[index]
                                                            .image,
                                                        name: _stories[index]
                                                            .name,
                                                      ),
                                                    );
                                                  }))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
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
                                            Tab(
                                              icon: Icon(
                                                  MaterialIcons.person_pin),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 408,
                                      width: MediaQuery.of(context).size.width,
                                      child: TabBarView(children: [
                                        Container(
                                          child: GridView.count(
                                            controller: _controller,
                                            physics: rechedtop
                                                ? NeverScrollableScrollPhysics()
                                                : null,
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 2,
                                            mainAxisSpacing: 2,
                                            children: _stories.map((story) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Posts()));
                                                },
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        story.image),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              'IGTV',
                                            ),
                                          ),
                                        ),

                                        // second tab bar viiew widget
                                        ProfileTap()
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
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ProfileTap extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.black)),
            child: Icon(
              MaterialIcons.person_pin,
              size: 38,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 80),
            alignment: Alignment.center,
            child: SizedBox(
                width: 300,
                child: Text("Photos and Videos of You",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    softWrap: true)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "When people tag you in photos and videos.",
            style: TextStyle(color: Colors.grey[500]),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "they'll appear here",
              style: TextStyle(color: Colors.grey[500]),
            ),
          )
        ],
      ),
    );
  }
}
