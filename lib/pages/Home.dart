import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bages'),
        centerTitle: true,
        actions: [
          Badge(
            position: BadgePosition.topEnd(top: 6, end: 6),
            badgeContent: Text(
              "5",
              style: TextStyle(color: Colors.white),
            ),
            badgeColor: Colors.red,
            child: IconButton(
              icon: Icon(
                Feather.send,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
