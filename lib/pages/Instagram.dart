import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/Post_item.dart';
import 'package:flutter_instagram_clone/pages/activity_screen.dart';
import 'package:flutter_instagram_clone/pages/comments.dart';
import 'package:flutter_instagram_clone/pages/constants.dart';
import 'package:flutter_instagram_clone/pages/story_item.dart';
import 'package:flutter_instagram_clone/resources/firebaseController.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
// import 'package:flutter_instagram_clone/services/user.dart';
import 'package:flutter_instagram_clone/stories/data.dart';
import 'package:flutter_instagram_clone/stories/models/user_model.dart';
import 'package:flutter_instagram_clone/stories/stories.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:provider/provider.dart';
import 'messages.dart';
import 'post.dart';
import 'story.dart';

class Home extends StatefulWidget {
  final bool isdownloading;
  Home({this.isdownloading = false});
  _HomeState createState() => _HomeState();
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class _HomeState extends State<Home> {
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

  //
  // TextEditingController _captionInputController = TextEditingController();
  File _image;
  pickFromCamer() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });
  }

  pickFromPhone() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  // the bottom sheet
  bool isdoubleclicked = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final StreamController<void> _streamController = StreamController.broadcast();
  Query bloobs = FirebaseFirestore.instance
      .collection("blobs")
      .orderBy("time", descending: true);
  bool isliked = false;
  int numberofrooms = 0;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  @override
  void initState() {
    super.initState();
    firebaseMethods.getroomshasunreadMessages(
        currentUser: _auth.currentUser.uid);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    // FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Image(
              image: AssetImage(
                "assets/images/instagram.png",
              ),
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          leading: IconButton(
            onPressed: pickFromCamer,
            icon: Icon(
              FontAwesome.camera,
              color: Colors.black,
            ),
          ),
          actions: [
            StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection("users")
                    .doc(_auth.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    int count = snapshot.data.data()['numberofrooms'];

                    if (count > 0) {
                      return Badge(
                          // toAnimate: false,
                          animationType: BadgeAnimationType.scale,
                          position: BadgePosition.topEnd(top: 6, end: 6),
                          badgeColor: Colors.red,
                          badgeContent: Text(
                            "$count",
                            style: TextStyle(color: Colors.white),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Messages()));
                            },
                            icon: Icon(
                              Feather.send,
                              color: Colors.black,
                            ),
                          ));
                    }
                    return IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Messages()));
                        },
                        icon: Icon(
                          Feather.send,
                          color: Colors.black,
                        ));
                  }
                  return IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Messages()));
                      },
                      icon: Icon(
                        Feather.send,
                        color: Colors.black,
                      ));
                }),
          ],
        ),
        body: GestureDetector(
          // onHorizontalDragEnd: (DragEndDetails dragEndDetails) {

          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => Messages()));
          // },
          child: StreamBuilder<DocumentSnapshot>(
            stream: users.doc(_auth.currentUser.uid).snapshots(),
            builder: (context, snapshot) => snapshot.hasData
                ? Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Divider(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 20, left: 15, bottom: 10),
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
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          snapshot.data.data()[
                                                              'photourl']),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 19,
                                                height: 19,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: Icon(
                                                  Icons.add_circle,
                                                  color: buttonFollowColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        width: 70,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Your story",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                    children:
                                        List.generate(_stories.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return StoryScreen(
                                          stories: stories,
                                          user: UserStory(
                                              name: _stories[index].name,
                                              profileImageUrl:
                                                  _stories[index].image),
                                        );
                                      }));
                                    },
                                    child: StoryItem(
                                      img: _stories[index].image,
                                      name: _stories[index].name,
                                    ),
                                  );
                                }))
                              ],
                            ),
                          ),

                          // // here
                          StreamBuilder<QuerySnapshot>(
                            stream: bloobs.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    itemCount: snapshot.data.docs.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      QueryDocumentSnapshot doc =
                                          snapshot.data.docs[index];
                                      String time =
                                          Jiffy(doc.data()['time']?.toDate())
                                              .fromNow();
                                      return PostItem(
                                        postid: doc.id,
                                        caption: doc.data()['caption'],
                                        uploaderId: doc.data()['uploaderId'],
                                        time: time,
                                        postphoto: doc.data()['url'],
                                        savelist: doc.data()['savelist'],
                                        likelist: doc.data()['likelist'],
                                      );
                                    },
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 1.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey[500])),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ));
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

// Container(
//   width: MediaQuery.of(context).size.width,
//   child: ListView.builder(
//     shrinkWrap: true,
//     itemCount: posts.length,
//     physics: NeverScrollableScrollPhysics(),
//     itemBuilder: (context, i) {
//       return Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: 10, vertical: 10),
//               child: Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius:
//                               BorderRadius.circular(
//                                   40),
//                           child: Image(
//                             image: NetworkImage(
//                                 posts[i].userImage),
//                             width: 40,
//                             height: 40,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(posts[i].username)
//                       ],
//                     ),
//                     IconButton(
//                       icon:
//                           Icon(Feather.more_vertical),
//                       onPressed: () {
//                         _onPressMoreButton();
//                       },
//                     )
//                   ]),
//             ),
//             GestureDetector(
//               onDoubleTap: () {
//                 setState(() {
//                   isdoubleclicked = true;
//                 });
//               },
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     // height: 200,
//                     child: InteractiveViewer(
//                       minScale: 1.0,
//                       maxScale: 6.0,
//                       child: FadeInImage.assetNetwork(
//                         image: posts[i].postImage,
//                         placeholder:
//                             "assets/images/spinner.gif",
//                         width: MediaQuery.of(context)
//                             .size
//                             .width,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   isdoubleclicked
//                       ? Positioned(
//                           child: IconButton(
//                               icon: Icon(
//                                 Icons.favorite,
//                                 color: Colors.white,
//                                 size: 100,
//                               ),
//                               onPressed: () {}),
//                         )
//                       : Text('')
//                 ],
//               ),
//             ),

//             Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           isliked = !isliked;
//                         });
//                       },
//                       icon: isliked
//                           ? Icon(FontAwesome.heart)
//                           : Icon(FontAwesome.heart_o),
//                       color: isliked
//                           ? Colors.red
//                           : Colors.black,
//                       iconSize: isliked ? 27 : 24,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder:
//                                       (context) =>
//                                           Comment()));
//                         },
//                         icon: Icon(
//                             FontAwesome.comment_o)),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Feather.send),
//                     )
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(FontAwesome.bookmark_o),
//                 )
//               ],
//             ),
//             Container(
//               width:
//                   MediaQuery.of(context).size.width,
//               margin: EdgeInsets.symmetric(
//                   horizontal: 14),
//               child: RichText(
//                 softWrap: true,
//                 overflow: TextOverflow.visible,
//                 text: TextSpan(children: [
//                   TextSpan(
//                     text: "Liked By ",
//                     style: TextStyle(
//                         color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: "Sigmund,",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: " Yessenia,",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: " Dayana",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: " and",
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                   TextSpan(
//                     text: " 1263 others",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ]),
//               ),
//             ),

//             // caption
//             Container(
//               width:
//                   MediaQuery.of(context).size.width,
//               margin: EdgeInsets.symmetric(
//                   horizontal: 14, vertical: 5),
//               child: RichText(
//                 softWrap: true,
//                 overflow: TextOverflow.visible,
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: posts[i].username,
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black),
//                     ),
//                     TextSpan(
//                       text: " ${posts[i].caption}",
//                       style: TextStyle(
//                           color: Colors.black),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // post date
//             Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: 14,
//               ),
//               alignment: Alignment.topLeft,
//               child: Text(
//                 "Febuary 2020",
//                 textAlign: TextAlign.start,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             )
//           ],
//         ),
//       );
//     },
//   ),
// )
