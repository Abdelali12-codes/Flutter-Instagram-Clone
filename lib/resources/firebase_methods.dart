import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_instagram_clone/enum/user_state.dart';
// import 'package:flutter_instagram_clone/models/reply.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_instagram_clone/models/room.dart';
import '../models/user.dart';
import '../models/message.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/utilities.dart';
import '../constants/strings.dart';
import '../provider/image_upload_provider.dart';

class FirebaseMethods {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // StorageReference _storageReference;

  // user Class
  Usermodel user = Usermodel();
  static FirebaseMethods get instance => FirebaseMethods();
  Future<User> getCurrretUser() async {
    User currentUser;
    currentUser = _auth.currentUser;

    return currentUser;
  }

  Future<Usermodel> getUserDetailsofuid({String uid}) async {
    DocumentSnapshot documentSnapshot = await users.doc(uid).get();
    return Usermodel.fromMap(documentSnapshot.data());
  }

  Future<Usermodel> getUserDetails() async {
    User currentUser = await getCurrretUser();
    DocumentSnapshot documentSnapshot = await users.doc(currentUser.uid).get();

    return Usermodel.fromMap(documentSnapshot.data());
  }

  Future<UserCredential> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await _signInAccount.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    UserCredential user = await _auth.signInWithCredential(credential);
    return user;
  }

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .where(EMAIL_FIELD, isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;
    // if user is registered the legth of list > 0
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(User currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = Usermodel(
        uid: currentUser.uid,
        email: currentUser.email,
        name: currentUser.displayName,
        profilePhoto: currentUser.photoURL,
        username: username);
    firestore
        .collection(USERS_COLLECTION)
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<Usermodel>> fetchAllUsers() async {
    List<Usermodel> userlist = List<Usermodel>();

    QuerySnapshot querySnapshot =
        await firestore.collection(USERS_COLLECTION).get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      userlist.add(Usermodel.fromMap(querySnapshot.docs[i].data()));
    }

    return userlist;
  }

  Future<List<Usermodel>> fetchAllRooms() async {
    List<Usermodel> users = List<Usermodel>();
    CollectionReference userscollection = firestore.collection("users");
    QuerySnapshot querySnapshot = await firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .collection("rooms")
        .orderBy("time", descending: true)
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      // rooms.add(Room.fromMap(querySnapshot.docs[i].data()));
      DocumentSnapshot documentSnapshot =
          await userscollection.doc(querySnapshot.docs[i].data()['with']).get();
      users.add(Usermodel.fromMap(documentSnapshot.data()));
    }

    return users;
  }

  void setUserState({@required String userId, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);

    users.doc(userId).update({
      "state": stateNum,
    });
  }

  Future<void> addMessageToDb(
      Message message, Usermodel sender, String roomid) async {
    var map = message.toMap();

    await firestore
        .collection(ROOM_COLLECTION)
        .doc(roomid)
        .collection(MESSAGES_COLLECTION)
        .add(map);
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    // mention try catch later on
    try {
      // _storageReference = FirebaseStorage.instance
      //     .ref()
      //     .child("${DateTime.now().millisecondsSinceEpoch}");

      // StorageUploadTask storageUploadTask =
      //     _storageReference.putFile(imageFile);
      // var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
      return "url";
    } catch (e) {
      return null;
    }
  }

  void setImageMsg(String url, String senderId, String roomId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        senderId: senderId,
        timestamp: Timestamp.now(),
        type: 'image');
    // create imagemap

    var map = message.toImageMap();
    //
    await firestore
        .collection(ROOM_COLLECTION)
        .doc(roomId)
        .collection(MESSAGES_COLLECTION)
        .add(map);
  }

  void uploadImage(File image, String senderId,
      ImageUploadProvider imageUploadProvider, String roomId) async {
    // get the url from the image bucket

    String url = await uploadImageToStorage(image);
    imageUploadProvider.setToIdle();
    setImageMsg(url, senderId, roomId);
  }

  Stream<QuerySnapshot> countUnreadMessages({String roomId}) {
    Stream<QuerySnapshot> unreadmessages = firestore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .where("unread", isEqualTo: true)
        .snapshots();

    return unreadmessages;
  }

  void readMessages({String roomId, String currentuser}) async {
    QuerySnapshot unreadmessages = await firestore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .where("unread", isEqualTo: true)
        .get();

    if (unreadmessages.docs.length > 0) {
      for (var i = 0; i < unreadmessages.docs.length; i++) {
        String user = unreadmessages.docs[i].data()["senderId"];
        if (user != currentuser) {
          await firestore
              .collection("rooms")
              .doc(roomId)
              .collection("messages")
              .doc(unreadmessages.docs[i].id)
              .update({"unread": false});
        }
      }
    }
  }

  // check the number of rooms has unread messages
  Future<void> getroomshasunreadMessages({String currentUser}) async {
    var count = 0;

    QuerySnapshot rooms = await firestore
        .collection("users")
        .doc(currentUser)
        .collection("rooms")
        .get();

    for (var i = 0; i < rooms.docs.length; i++) {
      // for each room , we will check wether the current room has unread messages ,while the senderId
      // is different then the current user

      QuerySnapshot unreadMessages = await firestore
          .collection("rooms")
          .doc(rooms.docs[i].id)
          .collection("messages")
          .where("unread", isEqualTo: true)
          .get();

      bool vl = unreadMessages.docs
              .where((doc) => doc.data()['senderId'] != currentUser)
              .length >
          0;
      if (vl) {
        count += 1;
      }
    }

    await firestore
        .collection("users")
        .doc(currentUser)
        .update({"numberofrooms": count});
  }

  Future<void> sendgetroomshasunreadMessages({String currentUser}) async {
    var count = 0;

    QuerySnapshot rooms = await firestore
        .collection("users")
        .doc(currentUser)
        .collection("rooms")
        .get();

    for (var i = 0; i < rooms.docs.length; i++) {
      // for each room , we will check wether the current room has unread messages ,while the senderId
      // is different then the current user

      QuerySnapshot unreadMessages = await firestore
          .collection("rooms")
          .doc(rooms.docs[i].id)
          .collection("messages")
          .where("unread", isEqualTo: true)
          .get();

      bool vl = unreadMessages.docs
              .where((doc) => doc.data()['senderId'] == currentUser)
              .length >
          0;
      if (vl) {
        count += 1;
        firestore
            .collection("users")
            .doc(rooms.docs[i].data()['with'])
            .update({"numberofrooms": count});
      }
    }
  }

  Future<void> isTyping({String query, String uid}) async {
    if (query.trim().length == 0) {
      await firestore.collection("users").doc(uid).update({"isTyping": false});
    } else if (query.trim().length == 1) {
      await firestore.collection("users").doc(uid).update({"isTyping": true});
    }
  }

  // Seen Status
  Future<void> seenStatus({String otheruser, String roomid}) async {
    QuerySnapshot unreadmessages = await firestore
        .collection("rooms")
        .doc(roomid)
        .collection("messages")
        .where("unread", isEqualTo: false)
        .where("senderId", isEqualTo: otheruser)
        .get();

    if (unreadmessages.docs.length > 0) {
      // check the last senderid in the room
      // and see if  it is the current user . if it is
      // then cheeck his message id and make it seen ;
      DocumentSnapshot room = await firestore
          .collection("users")
          .doc(otheruser)
          .collection("rooms")
          .doc(roomid)
          .get();

      if (room.data()['senderId'] == otheruser) {
        await firestore
            .collection("rooms")
            .doc(roomid)
            .collection("messages")
            .doc(room.data()['lastmessageId'])
            .update({"seen": true});
      }
    }
  }

  Future<void> saveLastmessageofcurrentUser(
      {String lastmessageid, String currentUser}) async {
    try {
      await firestore
          .collection("users")
          .doc(currentUser)
          .update({"lastmessageId": lastmessageid});
    } catch (e) {
      print(e.toString());
    }
  }

  // whenever a message deleted
  Future<void> updateRoomMessage(
      {String roomId, String currentUser, String receiverId}) async {
    QuerySnapshot messages = await firestore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .orderBy("time", descending: true)
        .get();
    QueryDocumentSnapshot message = messages.docs[0];

    try {
      await firestore
          .collection("users")
          .doc(currentUser)
          .collection("rooms")
          .doc(roomId)
          .update({
        "lastmessageId": message.id,
        "senderId": message.data()['senderId'],
        "time": message.data()['time'],
        "message": message.data()['message'],
        "type": message.data()['type']
      });
      await firestore
          .collection("users")
          .doc(receiverId)
          .collection("rooms")
          .doc(roomId)
          .update({
        "lastmessageId": message.id,
        "senderId": message.data()['senderId'],
        "time": message.data()['time'],
        "message": message.data()['message'],
        "type": message.data()['type']
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // made the seen message of the other user unseen
  Future<void> makeMessagesUnseen({String roomId}) async {
    QuerySnapshot messages = await firestore
        .collection("rooms")
        .doc(roomId)
        .collection("messages")
        .where("seen", isEqualTo: true)
        .get();

    for (var i = 0; i < messages.docs.length; i++) {
      await firestore
          .collection("rooms")
          .doc(roomId)
          .collection("messages")
          .doc(messages.docs[i].id)
          .update({"seen": false});
    }
  }

  Future<void> likedPost(
      {String postid, String uploaderid, String userid}) async {
    DocumentSnapshot blobget =
        await firestore.collection("blobs").doc(postid).get();
    DocumentReference blob = firestore.collection("blobs").doc(postid);

    DocumentReference bucket = firestore
        .collection("users")
        .doc(uploaderid)
        .collection("buckets")
        .doc(postid);

    // if the user has liked the post so unlike it
    // else like the post
    if (blobget.data()['likelist'].contains(userid)) {
      await blob.update({
        "likelist": FieldValue.arrayRemove([userid])
      });

      await bucket.update({
        "likelist": FieldValue.arrayRemove([userid])
      });
    } else {
      await blob.update({
        "likelist": FieldValue.arrayUnion([userid])
      });

      await bucket.update({
        "likelist": FieldValue.arrayUnion([userid])
      });
    }
  }

  Future<void> savePost(
      {String uploaderid, String postid, String userid}) async {
    DocumentReference user = firestore.collection("users").doc(userid);
    DocumentReference blob = firestore.collection("blobs").doc(postid);
    DocumentReference bucket = firestore
        .collection("users")
        .doc(uploaderid)
        .collection("buckets")
        .doc(postid);

    DocumentSnapshot blobget =
        await firestore.collection("blobs").doc(postid).get();

    if (blobget.data()['savelist'].contains(userid)) {
      await user.update({
        "postsaved": FieldValue.arrayRemove([postid])
      });

      await blob.update({
        "savelist": FieldValue.arrayRemove([userid])
      });

      await bucket.update({
        "savelist": FieldValue.arrayRemove([userid])
      });
    } else {
      await user.update({
        "postsaved": FieldValue.arrayUnion([postid])
      });

      await blob.update({
        "savelist": FieldValue.arrayUnion([userid])
      });

      await bucket.update({
        "savelist": FieldValue.arrayUnion([userid])
      });
    }
  }

  // add comments
  Future<void> addComment(
      {String postId, String uploaderId, String userId, String comment}) async {
    DocumentReference coment = await firestore
        .collection("blobs")
        .doc(postId)
        .collection("comments")
        .add({
      "comment": comment,
      "userid": userId, // user who commented on the post
      "time": FieldValue.serverTimestamp(),
      "likes": []
    });

    await firestore
        .collection("users")
        .doc(uploaderId)
        .collection("buckets")
        .doc(postId)
        .collection("comments")
        .doc(coment.id)
        .set({
      "comment": comment,
      "userid": userId, // user who commented on the post
      "time": FieldValue.serverTimestamp(),
      "likes": []
    });
  }

  // add replies of the comment

  Future<void> addReplies(
      {String commentId,
      String postId,
      String uploaderId,
      String userId,
      String reply}) async {
    DocumentReference blobcommentreply = firestore
        .collection("blobs")
        .doc(postId)
        .collection("comments")
        .doc(commentId);
    DocumentReference bucketcommentreply = firestore
        .collection("users")
        .doc(uploaderId)
        .collection("buckets")
        .doc(postId)
        .collection("comments")
        .doc(commentId);

    DocumentReference rply = await blobcommentreply.collection("replies").add({
      "reply": reply,
      "userid": userId,
      "time": FieldValue.serverTimestamp(),
      "likes": []
    });

    await bucketcommentreply.collection("replies").doc(rply.id).set({
      "reply": reply,
      "userid": userId,
      "time": FieldValue.serverTimestamp(),
      "likes": []
    });
  }

  // add reply to a comment
  Future<void> addReply(
      {String postid,
      String commentid,
      String uploaderid,
      String currentUser,
      String usertaged,
      String usertagedid,
      String reply}) async {
    DocumentReference rply = await firestore
        .collection("blobs")
        .doc(postid)
        .collection("comments")
        .doc(commentid)
        .collection("replies")
        .add({
      "userid": currentUser,
      "comment": reply,
      "time": FieldValue.serverTimestamp(),
      "likes": [],
      "type": "reply",
      "taged": "@$usertaged"
    });

    await firestore
        .collection("users")
        .doc(uploaderid)
        .collection("buckets")
        .doc(postid)
        .collection("comments")
        .doc(commentid)
        .collection("replies")
        .doc(rply.id)
        .set({
      "userid": currentUser,
      "comment": reply,
      "time": FieldValue.serverTimestamp(),
      "likes": [],
      "type": "reply",
      "taged": "@$usertaged"
    });
    // here we should add mentioned notifications
  }

  // retriev all replies for each doc ;
  Future<List<QueryDocumentSnapshot>> retriveAllReplies(
      {String postId, String commentId}) async {
    List<QueryDocumentSnapshot> replies;
    QuerySnapshot rplies = await firestore
        .collection("blobs")
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .collection("replies")
        .get();
    replies = [];
    replies.addAll(rplies.docs);
    return replies;
  }

  // like comment
  Future<void> likeComment(
      {String postId,
      String uploaderId,
      String userId,
      String commentId}) async {
    DocumentSnapshot comment = await firestore
        .collection("blobs")
        .doc(postId)
        .collection("comments")
        .doc(commentId)
        .get();

    if (comment.data()['likes'].contains(userId)) {
      await firestore
          .collection("blobs")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        "likes": FieldValue.arrayRemove([userId])
      });

      await firestore
          .collection("users")
          .doc(uploaderId)
          .collection("buckets")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        "likes": FieldValue.arrayRemove([userId])
      });
    } else {
      await firestore
          .collection("blobs")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        "likes": FieldValue.arrayUnion([userId])
      });
      await firestore
          .collection("users")
          .doc(uploaderId)
          .collection("buckets")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .update({
        "likes": FieldValue.arrayUnion([userId])
      });
    }
  }

  Future<void> likeReply(
      {String postid,
      String commentid,
      String uploaderid,
      String replyid, // uplader of the post
      String userid}) async {
    DocumentSnapshot reply = await firestore
        .collection("blobs")
        .doc(postid)
        .collection("comments")
        .doc(commentid)
        .collection("replies")
        .doc(replyid)
        .get();

    if (reply.data()['likes'].contains(userid)) {
      await firestore
          .collection("blobs")
          .doc(postid)
          .collection("comments")
          .doc(commentid)
          .collection("replies")
          .doc(replyid)
          .update({
        "likes": FieldValue.arrayRemove([userid])
      });

      await firestore
          .collection("users")
          .doc(uploaderid)
          .collection("buckets")
          .doc(postid)
          .collection("comments")
          .doc(commentid)
          .collection("replies")
          .doc(replyid)
          .update({
        "likes": FieldValue.arrayRemove([userid])
      });
    } else {
      await firestore
          .collection("blobs")
          .doc(postid)
          .collection("comments")
          .doc(commentid)
          .collection("replies")
          .doc(replyid)
          .update({
        "likes": FieldValue.arrayUnion([userid])
      });

      await firestore
          .collection("users")
          .doc(uploaderid)
          .collection("buckets")
          .doc(postid)
          .collection("comments")
          .doc(commentid)
          .collection("replies")
          .doc(replyid)
          .update({
        "likes": FieldValue.arrayUnion([userid])
      });
    }
  }

  Future<List<QueryDocumentSnapshot>> getAllCommentOfPost(
      {String postid}) async {
    List<QueryDocumentSnapshot> comments = [];

    QuerySnapshot snapshot = await firestore
        .collection("blobs")
        .doc(postid)
        .collection("comments")
        .get();
    comments = [];
    comments.addAll(snapshot.docs);
    return comments;
  }

  Future<List<QueryDocumentSnapshot>> getAllCommentoffollwedUsers(
      {String postid, List<dynamic> users}) async {
    List<QueryDocumentSnapshot> comments = [];

    QuerySnapshot snapshot = await firestore
        .collection("blobs")
        .doc(postid)
        .collection("comments")
        .where("userid", whereIn: users)
        .get();

    comments = [];
    comments.addAll(snapshot.docs);
    return comments;
  }

  // get all the following for the currentUser
  Future<List<dynamic>> getAllFollowedUsers({String currentUser}) async {
    List<dynamic> followedusers = [];

    DocumentSnapshot following =
        await firestore.collection("users").doc(currentUser).get();

    followedusers.addAll(following.data()['following']);
    // followedusers = following.data()['following'];
    return followedusers;
  }

  // notifications someone mentioned u in a post

  Future<void> mentionedNotification(
      {String userid,
      String type,
      String message,
      String mentionerid,
      String post}) async {
    await firestore
        .collection("users")
        .doc(userid)
        .collection("notifications")
        .add({
      "type": "mentioned",
      "time": FieldValue.serverTimestamp(),
      "mentionerid": mentionerid,
      "message": message,
    });
  }

  // add like notification
  Future<void> addlikeNotification(
      {String userid, String type, String liker, String postid}) async {
    await firestore
        .collection("users")
        .doc(userid)
        .collection("notifications")
        .add({
      "type": "like",
      "time": FieldValue.serverTimestamp(),
      "message": "Like your post",
      "postid": postid
    });
  }

  // add comment notifications
  Future<void> addCommentNotif(
      {String postid,
      String type,
      String comment,
      String userid,
      String uploaderid}) async {
    await firestore
        .collection("users")
        .doc(uploaderid)
        .collection("notifications")
        .add({
      "type": "comment",
      "message": comment,
      "time": FieldValue.serverTimestamp(),
      "userid": userid
    });
  }

  // add notifications
  Future<void> addNotifications({String userid, String notifcationtype}) async {
    await firestore
        .collection("users")
        .doc(userid)
        .collection("notifications")
        .add({"time": FieldValue.serverTimestamp()});
  }

  // follow and unfollow
  Future<void> followUser({String currentUseruid, String otheruid}) async {
    DocumentSnapshot follow =
        await firestore.collection("users").doc(currentUseruid).get();

    if (follow.data()["following"].contains(otheruid)) {
      await firestore.collection("users").doc(currentUseruid).update({
        "following": FieldValue.arrayRemove([otheruid])
      });

      await firestore.collection("users").doc(otheruid).update({
        "followers": FieldValue.arrayRemove([currentUseruid])
      });
    } else {
      await firestore.collection("users").doc(currentUseruid).update({
        "following": FieldValue.arrayUnion([otheruid])
      });

      await firestore.collection("users").doc(otheruid).update({
        "followers": FieldValue.arrayUnion([currentUseruid])
      });
    }
  }

  // read all notifications
  Future<void> readAllNotifications() async {}

  // count all the unread notifications
  Future<void> counAllUnreadNotifications() async {}
}
