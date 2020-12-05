import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/search_accounts.dart';
import 'package:flutter_instagram_clone/constants/images.dart';

class SearchCom extends StatefulWidget {
  @override
  _SearchComState createState() => _SearchComState();
}

class _SearchComState extends State<SearchCom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  iconSize: 30,
                  onPressed: () {},
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchAccount()));
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(AntDesign.scan1),
            color: Colors.black,
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    // padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 30,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton.icon(
                            icon: Icon(
                              MaterialIcons.live_tv,
                              size: 26,
                            ),
                            label: Text(
                              'IGTV',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton.icon(
                            icon: Icon(MaterialCommunityIcons.shopping),
                            label: Text(
                              'Shop',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Travel',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Architecture',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Decor',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Art',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Food',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Style',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Tv & Movies',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'DIY',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Music',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Sports',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Beauty',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                children: list.map((image) {
                  return Container(
                      child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/spinner.gif",
                    image: image.url,
                    fit: BoxFit.cover,
                  ));
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
