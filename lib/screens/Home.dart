import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
}

Color PrimaryColor = Color(0xFF109618);

class _HomepageState extends State<Homepage> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: _GooglePlayAppBar(),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 6.0,
            onTap: (index) {
              setState(() {
                switch (index) {
                  case 0:
                    PrimaryColor = Color(0xffff5722);
                    break;
                  case 1:
                    PrimaryColor = Color(0xff3f51b5);
                    break;
                  case 2:
                    PrimaryColor = Color(0xffE91E63);
                    break;
                  case 3:
                    PrimaryColor = Color(0xff9C27B0);
                    break;
                  case 4:
                    PrimaryColor = Color(0xff2196F3);
                    break;
                  default:
                }
              });
            },
            tabs: [
              Tab(
                child: Container(
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Games',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Movies',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Book',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    'Music',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [],
        ),
      ),
    );
  }
}

Widget _GooglePlayAppBar() {
  return Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: IconButton(
            icon: Icon(FontAwesome.bars),
            onPressed: () {},
          ),
        ),
        Container(
          child: Text(
            "Google Play",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(FontAwesome.microphone),
            color: Colors.blueGrey,
            onPressed: null,
          ),
        )
      ],
    ),
  );
}
