import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/comment_item_select.dart';
import 'package:flutter_instagram_clone/utils/comment_sheetbuttom.dart';
import 'package:flutter_instagram_clone/utils/time_ago_since_now.dart';

class OtherComment extends StatefulWidget {
  final String pressedcommentid;
  final String postId;
  final String uploaderId;
  final String caption;
  final String time;
  final String commentowner;
  OtherComment(
      {this.pressedcommentid,
      this.postId,
      this.uploaderId,
      this.caption,
      this.time,
      this.commentowner});
  @override
  _OtherCommentState createState() => _OtherCommentState();
}

class _OtherCommentState extends State<OtherComment> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference comments;

  void itisReply(String whomyoutaged) {
    print(whomyoutaged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "1 Selected",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(
              Entypo.cross,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                EvilIcons.exclamation,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                exclamationIcon(context, widget.commentowner);
              },
            )
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // the caption of the post
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: firestore
                                  .collection("users")
                                  .doc(widget.uploaderId)
                                  .snapshots(),
                              builder: (context, snapshotdoc) => (snapshotdoc
                                          .hasData &&
                                      snapshotdoc.data != null)
                                  ? Row(
                                      // info of the user uploader of the post
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // the poster pic
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              padding: EdgeInsets.all(1),
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    fit: BoxFit.cover,
                                                    image: snapshotdoc.data
                                                        .data()['photourl'],
                                                    placeholder:
                                                        "assets/images/spinner.gif",
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: 20),
                                        // the caption

                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: snapshotdoc.data
                                                          .data()['username'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(text: " "),
                                                  TextSpan(
                                                      text: widget.caption,
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  // the time
                                                  TextSpan(text: "."),
                                                  // TextSpan(
                                                  //     text: widget.time,
                                                  //     style: TextStyle(
                                                  //         color:
                                                  //             Colors.grey[500]))
                                                ])),
                                                SizedBox(height: 6),
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: timefromNowString(
                                                            date: widget.time),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500]))
                                                  ]),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Text(""),
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(),
                          SizedBox(height: 10),

                          StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection("blobs")
                                .doc(widget.postId)
                                .collection("comments")
                                .orderBy("time", descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      QueryDocumentSnapshot comment =
                                          snapshot.data.docs[index];
                                      return CommentItem(
                                        pressed: widget.pressedcommentid ==
                                            comment.id,
                                        commentid: comment.id,
                                        uploaderid: widget.uploaderId,
                                        userid: comment.data()['userid'],
                                        comment: comment.data()['comment'],
                                        likes: comment.data()["likes"],
                                        postid: widget.postId,
                                        itIsReply: itisReply,
                                        time: timefromNow(
                                            time: comment
                                                .data()['time']
                                                ?.toDate()),
                                        replies: 7,
                                      );
                                    },
                                  ),
                                );
                              }
                              return Text("");
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
