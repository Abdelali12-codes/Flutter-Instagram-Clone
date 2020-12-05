import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;

  String type;
  String message;
  Timestamp timestamp;
  String photourl;

  Message({this.senderId, this.type, this.message, this.timestamp});

  // named constructor
  Message.imageMessage(
      {this.senderId, this.message, this.type, this.timestamp, this.photourl});
  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Map toImageMap() {
    var map = Map<String, dynamic>();
    map['message'] = this.message;
    map['senderId'] = this.senderId;

    map['type'] = this.type;
    map['timestamp'] = this.timestamp;
    map['photourl'] = this.photourl;

    return map;
  }

  // named constructor ;
  Message.fromMap(Map<String, dynamic> map) {
    this.senderId = map['senderId'];

    this.type = map['type'];
    this.message = map['message'];
    this.timestamp = map['timestamp'];
    this.photourl = map['photourl'];
  }
}
