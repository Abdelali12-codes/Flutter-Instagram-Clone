import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class App2 extends StatelessWidget {
  // FirebaseFirestore _users = FirebaseFirestore.instance ;
  CollectionReference _users = FirebaseFirestore.instance.collection("users");
  List<int> hightlights = [1, 2, 3, 3, 3, 4, 4];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App'),
          centerTitle: true,
        ),
        body: Container(
            color: Colors.amber,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              // width: MediaQuery.of(context).size.width,
              // padding:
              //     EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              // color: Colors.amber,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Hello world'),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Hello world'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.red,
                    height: 30,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/avatar1.png"),
                        maxRadius: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('posts'),
                              Text('54'),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text('followers'),
                              Text('54'),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text('following'),
                              Text('54'),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        child: Text('highlights'),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        child: Text('promotion'),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        child: Text('promotion'),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 110,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: hightlights.map((iem) {
                            return Column(children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    border: Border.all(
                                        width: 3, color: Color(0xFF8E44AD))),
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/avatar1.png"),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          }).toList()))
                ],
              ),
            )));
  }
}
