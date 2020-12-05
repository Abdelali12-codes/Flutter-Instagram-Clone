import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<int> list = List.generate(30, (index) => index + 1);
  ScrollController _controller;
  ScrollController _scrollController;
  bool rechedtop = false;
  _scrollLitener() {
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print("you reaced the top");
      setState(() {
        rechedtop = true;
      });
    }
  }

  _scrollContolViewListener() {
    print("${_scrollController.position.pixels} view");
    if (_scrollController.position.pixels == 400) {
      setState(() {
        rechedtop = false;
      });
    }
  }

  void initState() {
    _controller = ScrollController();
    _scrollController = ScrollController();
    _controller.addListener(_scrollLitener);
    _scrollController.addListener(_scrollContolViewListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Profile',
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[700].withOpacity(0.4),
          elevation: 0,
          leading: Icon(
            Icons.menu,
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.purple,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: AppBar(
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            icon: Icon(Icons.directions_bike),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.directions_car,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.directions_car,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 462,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: TabBarView(children: [
                      Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'Bike',
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'Bike',
                          ),
                        ),
                      ),
                      // second tab bar viiew widget
                      Container(
                          color: Colors.pink,
                          child: GridView.count(
                            controller: _controller,
                            physics: rechedtop
                                ? NeverScrollableScrollPhysics()
                                : null,
                            crossAxisCount: 3,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            children: list.map((e) {
                              return Container(
                                child: Image(
                                  image:
                                      AssetImage("assets/images/avatar1.png"),
                                ),
                              );
                            }).toList(),
                          )),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
