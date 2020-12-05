import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/pages/reply_item.dart';
import 'package:flutter_instagram_clone/utils/time_ago_since_now.dart';
// import 'package:flutter_instagram_clone/models/reply.dart';

class Reply extends StatefulWidget {
  final String commentId;
  final String postId;
  final String uploaderId;
  Reply({this.commentId, this.postId, this.uploaderId});
  @override
  _ReplyState createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool showreplies = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection("blobs")
            .doc(widget.postId)
            .collection("comments")
            .doc(widget.commentId)
            .collection("replies")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data.docs.length > 0) {
              return Column(children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showreplies = !showreplies;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      left: 40,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 1,
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        showreplies
                            ? Text("Hide replies",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500]))
                            : Text("View ${snapshot.data.docs.length} replies",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ),
                showreplies
                    ? (Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.90,
                              child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot doc =
                                      snapshot.data.docs[index];
                                  return ReplayItem(
                                    taged: doc.data()['taged'],
                                    replyid: doc.id,
                                    postid: widget.postId,
                                    uploaderid: widget.uploaderId,
                                    commentid: widget.commentId,
                                    likes: doc.data()['likes'],
                                    userid: doc
                                        .data()['userid'], // user who replied
                                    comment: doc.data()['comment'],
                                    time: timefromNow(
                                        time: doc.data()['time']?.toDate()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                    : SizedBox(height: 0, width: 0),
              ]);
            }
            return SizedBox(
              height: 0,
            );
          }
          return SizedBox(height: 0);
        });
  }
}
