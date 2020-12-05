import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/provider/tag_provider.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_instagram_clone/constants/images.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  final String uploaderId;
  final String commentid;
  final bool itisreply;
  final String tagedusername;
  CommentInput(
      {this.postId,
      this.uploaderId,
      this.itisreply,
      this.commentid,
      this.tagedusername});
  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  TextEditingController _controller = TextEditingController();
  bool isCommented = false;
  bool isselect = false;
  bool isreply = false;
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FocusNode focusNode;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> list = ["😍", "🤣", "🤗", "😋", "❤️", "😰", "😘", "😛"];
  List<String> replytext = [];
  List<String> emojinames = [
    "eyesheart",
    "laugh",
    "hugging",
    "savoring",
    "heart",
    "sad",
    "kiss",
    "facewithtongue"
  ];
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  void emojiComment({int index}) {
    switch (index) {
      case 0:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));

        break;

      case 1:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];

        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        break;

      case 2:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        break;
      case 3:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        break;
      case 4:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        break;

      case 5:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        break;

      case 6:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));

        break;

      case 7:
        setState(() {
          isCommented = true;
        });
        _controller.text += list[index];
        _controller.selection = TextSelection.fromPosition(
            new TextPosition(offset: _controller.text.length));
        break;
      case 8:
        setState(() {
          isCommented = true;
          isreply = true;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
        stream: users.doc(_auth.currentUser.uid).snapshots(),
        builder: (context, snapshot) => snapshot.hasData &&
                snapshot.data != null
            ? Consumer<TagProvider>(builder: (context, tag, _) {
                if (tag.getUser.username.trim().length > 0 &&
                    !_controller.text.contains(tag.getUser.username.trim())) {
                  _controller.text = "@${tag.getUser.username} ";
                  _controller.selection = TextSelection.fromPosition(
                      new TextPosition(offset: _controller.text.length));
                  focusNode.requestFocus();
                }

                return Column(
                  children: [
                    tag.getUser.iscomment
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            color: Colors.grey[300],
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Replying to ${tag.getUser.username}",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(Entypo.cross),
                                  onPressed: () {
                                    tag.delete();
                                    _controller.text = "";
                                  },
                                )
                              ],
                            ),
                          )
                        : SizedBox(height: 0, width: 0),
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width,

                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            height: 40,
                            child: ListView.builder(
                                padding: EdgeInsets.only(right: 6 , left:6 ),
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      emojiComment(index: index);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: ((size.width / 8) * 0.2),
                                        ),
                                        child: Text(
                                          list[index],
                                          style: TextStyle(fontSize: 24),
                                        )),
                                  );
                                }),
                          ),
                          Divider(
                            height: 4,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            "assets/images/spinner.gif",
                                        image:
                                            snapshot.data.data()['photourl']),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: TextFormField(
                                      // autofocus: true,

                                      focusNode: focusNode,
                                      controller: _controller,
                                      minLines: 1,
                                      maxLines: 5,
                                      onChanged: (value) {
                                        if (value.length > 0 &&
                                            value.trim() != "") {
                                          // if (value.contains("@")) {
                                          //   setState(() {
                                          //     isreply = true;
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     isreply = false;
                                          //   });
                                          // }

                                          setState(() {
                                            isCommented = true;
                                          });
                                        } else if (value.isEmpty) {
                                          setState(() {
                                            isCommented = false;
                                          });
                                        }
                                      },
                                      cursorColor: Colors.green[500],
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Type your comment",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[300])),
                                    ),
                                  ),
                                ),
                                (isCommented || tag.getUser.iscomment)
                                    ? (isreply || tag.getUser.isreplay)
                                        ? GestureDetector(
                                            onTap: () {
                                              // print(_controller.text);

                                              replytext =
                                                  _controller.text.split(" ");

                                              replytext = replytext
                                                  .where((element) =>
                                                      !element.contains("@"))
                                                  .toList();
                                              // print(replytext.join(" "));
                                              firebaseMethods.addReply(
                                                  usertaged:
                                                      tag.getUser.username,
                                                  usertagedid:
                                                      tag.getUser.userid,
                                                  postid: widget.postId,
                                                  uploaderid: widget.uploaderId,
                                                  commentid:
                                                      tag.getUser.commentid,
                                                  currentUser:
                                                      _auth.currentUser.uid,
                                                  reply: replytext.join(" "));
                                              _controller.text = '';
                                              tag.delete();
                                              setState(() {
                                                isCommented = false;
                                              });
                                            },
                                            child: Text(
                                              'Post',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 16),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              // print(_controller.text);

                                              firebaseMethods.addComment(
                                                  postId: widget.postId,
                                                  uploaderId: widget.uploaderId,
                                                  userId: _auth.currentUser.uid,
                                                  comment:
                                                      _controller.text.trim());
                                              _controller.text = '';
                                              tag.delete();
                                              setState(() {
                                                isCommented = false;
                                              });
                                            },
                                            child: Text(
                                              'Post',
                                              style: TextStyle(
                                                  color: Colors.blue[500],
                                                  fontSize: 16),
                                            ),
                                          )
                                    : Text(
                                        'Post',
                                        style:
                                            TextStyle(color: Colors.blue[100]),
                                      )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              })
            : Text(""));
  }
}
