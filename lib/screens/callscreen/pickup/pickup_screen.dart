import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/call.dart';
import 'package:flutter_instagram_clone/resources/call_methods.dart';
import 'package:flutter_instagram_clone/screens/callscreen/call_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PickupScreen extends StatefulWidget {
  final Call call;

  PickupScreen({this.call});

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            Color(0xFFD9E4DD),
            Color(0xFF92817A),
            Color(0xFF373A40),
            Color(0xFF838383)
          ])),
      width: size.width,
      height: size.height,
      // alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(vertical: 100),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 100,
            width: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image(
                  image: NetworkImage(widget.call.callerPic),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.call.callerName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Incoming...", style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.call_end,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await callMethods.endCall(call: widget.call);
                  },
                ),
              ),
              SizedBox(width: 25),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await [
                      Permission.camera,
                      Permission.microphone,
                      Permission.storage
                    ].request();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CallScreen(
                                  call: widget.call,
                                  hasDialled: false,
                                )));
                  },
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
