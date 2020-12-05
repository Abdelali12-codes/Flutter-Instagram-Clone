import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/constants/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Followers extends StatefulWidget {
  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // the usrname
          title: Text(
            'abdelali.codes',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Feather.arrow_left),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              indicatorWeight: 1,
              unselectedLabelColor: Colors.grey[400],
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: "264 Follwers",
                ),
                Tab(
                  text: "1,298 Follwing",
                )
              ]),
        ),
        body: TabBarView(
          children: [
            Follower(
              list: list,
            ),
            Following(
              list: list,
            )
          ],
        ),
      ),
    );
  }
}

class Following extends StatelessWidget {
  List<ImageClass> list;
  Following({this.list});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search following...",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(11),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect Contacts',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            "Follow people you know",
                            style: TextStyle(color: Colors.grey[500]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 2),
                      alignment: Alignment.bottomRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(6)),
                              child: FlatButton(
                                child: Text(
                                  "Connect",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Entypo.cross,
                                  color: Colors.grey[500],
                                ),
                                onPressed: () {})
                          ]),
                    )
                  ],
                ),
              )
            ]),
          ),
          Divider(),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Categories',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        // color: Colors.purple,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        width: 99,
                        height: 80,
                        child: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/spinner.gif",
                                  image: list[4].url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.red,
                              ),
                            ),
                            Positioned(
                                left: 25,
                                top: 14,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/spinner.gif",
                                        image: list[1].url,
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
                        width: 15,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Least Interact With",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("engineering.principles and 49 others",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                )),
                          ]),
                    ]),
                    Row(children: [
                      Container(
                        // color: Colors.purple,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        width: 99,
                        height: 80,
                        child: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/spinner.gif",
                                  image: list[3].url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            Positioned(
                                left: 25,
                                top: 14,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/spinner.gif",
                                        image: list[5].url,
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
                        width: 15,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Least Interact With",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("engineering.principles and 49 others",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                )),
                          ]),
                    ]),
                  ],
                ),
              )
            ],
          ),
          Divider(),
          SizedBox(
            height: 13,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Sorted by",
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: " Default",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: IconButton(
                    iconSize: 13,
                    icon: SvgPicture.asset("assets/svg/arrows.svg"),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Divider(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list.map(
                (image) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.assetNetwork(
                                  placeholder: "assets/images/spinner.gif",
                                  image: image.url,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    image.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    image.username,
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                          Container(
                              child: Row(children: [
                            Container(
                                height: 27,
                                alignment: Alignment.center,
                                child: FlatButton(
                                  onPressed: () {},
                                  child: Text("Follwing",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1, color: Colors.grey[500]))),
                            Icon(Icons.more_vert)
                          ]))
                        ]),
                  );
                },
              ).toList(),
            ),
          )
        ],
      )),
    );
  }
}

class Follower extends StatelessWidget {
  List<ImageClass> list;
  Follower({this.list});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            // color: Colors.red,
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
                decoration: InputDecoration(
              hintText: "Search followers...",
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
            )),
          ),
          Column(
            children: list.map((image) {
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/spinner.gif",
                      image: image.url,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: SizedBox(
                  width: 120,
                  child: Text(
                    image.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
                subtitle: SizedBox(
                  width: 120,
                  child: Text(
                    image.username,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                trailing: Container(
                  width: 100,
                  height: 23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.grey[500])),
                  child: FlatButton(
                    child: Text(
                      "Remove",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    onPressed: () {},
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    ));
  }
}
