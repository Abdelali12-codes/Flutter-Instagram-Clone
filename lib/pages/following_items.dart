import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:flutter_instagram_clone/utils/storie_post_items.dart';

class FollowingItems extends StatefulWidget {
  final List<dynamic> followers;
  final String userid;
  FollowingItems({this.followers, this.userid});
  @override
  _FollowingItemsState createState() => _FollowingItemsState();
}

class _FollowingItemsState extends State<FollowingItems> {
  bool isfollow = false;
  bool isfollowing = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    // check if the my array of follwing contains the id of this user
    isfollowing = widget.followers.contains(_auth.currentUser.uid);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // the follow , message , arrow dwn
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 32,
                  width: 140,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color:
                          isfollowing ? Colors.transparent : Colors.blue[400],
                      border: isfollowing
                          ? Border.all(
                              style: BorderStyle.solid,
                              width: 1,
                              color: Colors.grey[400])
                          : Border.all(
                              style: BorderStyle.solid,
                              width: 0,
                              color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(6)),
                  child: FlatButton(
                    child: Text(isfollowing ? 'following' : 'follow',
                        style: TextStyle(
                            color: isfollowing ? Colors.black : Colors.white)),
                    onPressed: () {
                      setState(() {
                        isfollow = !isfollow;
                        isfollowing = !isfollowing;
                      });
                      firebaseMethods.followUser(
                          currentUseruid: _auth.currentUser.uid,
                          otheruid: widget.userid);
                    },
                  ),
                ),
                Container(
                  height: 32,
                  width: 140,
                  margin: EdgeInsets.only(left: 8, right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(6)),
                  child: FlatButton(
                    child: Text('message'),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 32,
                  width: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(MaterialIcons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
          Divider(),
          isfollow
              ? Column(
                  children: [
                    // the row
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Suggested for you",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Text(
                                "See All",
                                style: TextStyle(
                                    color: Colors.blue[300],
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                    // the suggested people
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10),
                      height: 250,
                      child: ListView.builder(
                        itemCount: stories.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String url = stories[index].image;
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: Colors.grey[500])),
                            width: 200,
                            // height: 240,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 1,
                                  top: 1,
                                  child: IconButton(
                                    icon: Icon(Entypo.cross),
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  width: 200,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // the avatar
                                      CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(url)),
                                      // username then the full name
                                      Column(
                                        children: [
                                          Text(
                                            "abdelai.codes",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "abdelali jad",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        ],
                                      ),
                                      // the follow button
                                      RaisedButton(
                                        child: Text(
                                          "follow",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onPressed: () {},
                                        color: Colors.blue[300],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
