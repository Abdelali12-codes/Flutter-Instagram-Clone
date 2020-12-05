// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';

// import 'package:percent_indicator/percent_indicator.dart';

// class Activity extends StatefulWidget {
//   final File image;
//   final String caption;

//   Activity({this.image, this.caption});

//   @override
//   _ActivityState createState() => _ActivityState();
// }

// class _ActivityState extends State<Activity> {
//   StorageUploadTask task;

//   FirebaseAuth _auth = FirebaseAuth.instance;

//   CollectionReference blobs = FirebaseFirestore.instance.collection("blobs");

//   CollectionReference users = FirebaseFirestore.instance.collection("users");

//   Future<void> _uploadFile(File image) async {
//     String file = image.path.split("/").last;
//     String imageTimeStampe = DateTime.now().millisecondsSinceEpoch.toString();
//     String filepath = "blobs/$imageTimeStampe/$file";
//     try {
//       StorageReference storageReference =
//           FirebaseStorage().ref().child(filepath);
//       StorageUploadTask uploadTask = storageReference.putFile(image);
//       setState(() {
//         task = uploadTask;
//       });
//       StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

//       String url = await storageTaskSnapshot.ref.getDownloadURL();
//       blobs.add({
//         "url": url,
//         "caption": widget.caption,
//         "savelist": [],
//         "likelist": [],
//         "uploaderId": _auth.currentUser.uid,
//         "time": FieldValue.serverTimestamp()
//       }).then((docRef) {
//         users
//             .doc(_auth.currentUser.uid)
//             .collection("buckets")
//             .doc(docRef.id)
//             .set({
//           "url": url,
//           "caption": widget.caption,
//           "savelist": [],
//           "likelist": [],
//           "time": FieldValue.serverTimestamp()
//         });
//       });
//     } catch (e) {
//       print(e.toString());
//     }

//     // return ActivityScreen();
//   }

//   Widget build(BuildContext context) {
//     _uploadFile(widget.image);
//     return ActivityScreen(
//       image: widget.image,
//       task: task,
//     );
//   }
// }

// class ActivityScreen extends StatefulWidget {
//   final File image;
//   final StorageUploadTask task;
//   ActivityScreen({Key key, this.image, this.task}) : super(key: key);
//   @override
//   _ActivityScreenState createState() => _ActivityScreenState();
// }

// class _ActivityScreenState extends State<ActivityScreen> {
//   final _key = GlobalKey<ScaffoldState>();
//   bool iscompleted = false;
//   StorageTaskSnapshot snapshot;

//   void status() {
//     if (widget.task.isComplete) {
//       setState(() {
//         iscompleted = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _key,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: Text(
//             "Activity",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ),
//         body: StreamBuilder<StorageTaskEvent>(
//             stream: widget.task.events,
//             builder: (context, asyncSnapshot) => asyncSnapshot.hasData
//                 ? Center(
//                     child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 8),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 60,
//                               width: 60,
//                               child: widget.image != null
//                                   ? Image.file(
//                                       widget.image,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : FadeInImage.assetNetwork(
//                                       placeholder: "assets/images/spinner.gif",
//                                       image:
//                                           "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=80&w=80",
//                                       fit: BoxFit.cover,
//                                     ),
//                             ),
//                             SizedBox(
//                               width: 8,
//                             ),
//                             Expanded(
//                               child: widget.task.isComplete
//                                   ? Row(
//                                       children: [
//                                         Icon(
//                                           Feather.check,
//                                           color: Colors.grey[500],
//                                           size: 26,
//                                         ),
//                                         Text(
//                                           "Finishing up",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     )
//                                   : LinearPercentIndicator(
//                                       percent: asyncSnapshot
//                                               .data.snapshot.bytesTransferred
//                                               .toDouble() /
//                                           asyncSnapshot
//                                               .data.snapshot.totalByteCount
//                                               .toDouble(),
//                                       backgroundColor: Colors.grey[300],
//                                       progressColor: Colors.blue[400],
//                                       lineHeight: 3.0,
//                                       width: 270,
//                                     ),
//                             ),
//                           ],
//                         )))
//                 : Text("")));
//   }
// }
