import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/call.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/resources/call_methods.dart';
// import '../pages/webrtc/call_screen.dart';
import 'package:flutter_instagram_clone/screens/callscreen/call_screen.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({Usermodel from, Usermodel to, String roomId, context}) async {
    Call call = Call(
        callerId: from.uid,
        callerName: from.name,
        callerPic: from.profilePhoto,
        receiverId: to.uid,
        receiverName: to.name,
        receiverPic: to.profilePhoto,
        channelId: roomId);
    bool callMade = await callMethods.makeCall(call: call);
    call.hasDialled = true;

    if (callMade) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CallScreen(
                    call: call,
                  )));
    }
  }
}
