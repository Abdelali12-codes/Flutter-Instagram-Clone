import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'dart:math';

// InstaProfilePage
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  double get randHeight => Random().nextInt(100).toDouble();
  Widget _randomHeightWidgets(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 30,
      child: Text('Random Height Child '),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      appBar: AppBar(
        title: Text('AppBar'),
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Floating Nested SliverAppBar'),
                floating: true,
                expandedHeight: 200.0,
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          // You tab view goes here
          body: Column(
            children: <Widget>[
              TabBar(
                indicatorColor: Colors.grey[400],
                tabs: [
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Icon(
                        MaterialCommunityIcons.table_large,
                        color: Colors.black,
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Icon(
                        Feather.tv,
                        color: Colors.black,
                      )),
                  Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Icon(
                        Feather.user,
                        color: Colors.black,
                      ))
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      children: [1, 2, 3, 4, 4].map((e) {
                        return Image(
                          image: AssetImage("assets/images/avatar1.png"),
                        );
                      }).toList(),
                    ),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      children: [1, 2, 3, 4, 4].map((e) {
                        return Image(
                          image: AssetImage("assets/images/avatar1.png"),
                        );
                      }).toList(),
                    ),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      children: [1, 2, 3, 4, 4].map((e) {
                        return Image(
                          image: AssetImage("assets/images/avatar1.png"),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
