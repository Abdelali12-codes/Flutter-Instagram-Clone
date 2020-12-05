import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/call.dart';

class CallLeft extends StatefulWidget {
  final Call call;
  CallLeft({this.call});
  @override
  _CallLeftState createState() => _CallLeftState();
}

class _CallLeftState extends State<CallLeft> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

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
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // color: Colors.purple,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              width: 180,
              height: 180,
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/images/spinner.gif",
                        image: widget.call.callerPic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.red,
                    ),
                  ),
                  Positioned(
                      left: 35,
                      top: 35,
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF838383)),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/spinner.gif",
                              image: widget.call.receiverPic,
                              fit: BoxFit.cover,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.blue,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              "You Left",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
