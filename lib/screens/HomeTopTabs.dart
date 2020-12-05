import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeTopTabs extends StatefulWidget {
  HomeTopTabs(this.colorVal);

  int colorVal;
  _HomeTopTabsState createState() => _HomeTopTabsState();
}

class _HomeTopTabsState extends State<HomeTopTabs>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void initState() {
    _tabController = TabController(vsync: this, length: 6);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {
      widget.colorVal = 0xfff5722;
    });
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor: Color(0xFFFF5722),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(
                  FontAwesome.compass,
                  color: _tabController.index == 0
                      ? Color(widget.colorVal)
                      : Colors.grey,
                ),
                child: Text(
                  'For You',
                  style: TextStyle(
                      color: _tabController.index == 0
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesome.bar_chart,
                  color: _tabController.index == 1
                      ? Color(widget.colorVal)
                      : Colors.grey,
                ),
                child: Text(
                  'For You',
                  style: TextStyle(
                      color: _tabController.index == 1
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesome.share_square_o,
                  color: _tabController.index == 2
                      ? Color(widget.colorVal)
                      : Colors.grey,
                ),
                child: Text(
                  'For You',
                  style: TextStyle(
                      color: _tabController.index == 2
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesome.bookmark_o,
                  color: _tabController.index == 3
                      ? Color(widget.colorVal)
                      : Colors.grey,
                ),
                child: Text(
                  'Family',
                  style: TextStyle(
                      color: _tabController.index == 3
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesome.compass,
                  color: _tabController.index == 4
                      ? Color(widget.colorVal)
                      : Colors.grey,
                ),
                child: Text(
                  'Early Access',
                  style: TextStyle(
                      color: _tabController.index == 4
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesome.compass,
                  color: _tabController.index == 5
                      ? Color(widget.colorVal)
                      : Colors.grey,
                ),
                child: Text(
                  'Editors choice',
                  style: TextStyle(
                      color: _tabController.index == 5
                          ? Color(widget.colorVal)
                          : Colors.grey),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [],
        ),
      ),
    );
  }
}
