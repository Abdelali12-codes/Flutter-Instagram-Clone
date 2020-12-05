import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Bio extends StatefulWidget {
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Bio",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Entypo.cross),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Feather.check),
            color: Colors.blue,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
