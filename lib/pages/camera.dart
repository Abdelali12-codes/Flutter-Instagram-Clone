import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Camer", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(
            Feather.arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
