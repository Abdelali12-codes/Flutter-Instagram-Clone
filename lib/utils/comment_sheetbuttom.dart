import 'package:flutter/material.dart';

void onPressMoreButton(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            color: Color(0xFF000000).withOpacity(0.57),
            // constraints: BoxConstraints(minHeight: 900),
            height: 500,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 6,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 14),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Report...",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Turn onPost Notification",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Copy Link",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Shared to...",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Unfollow",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Mute",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ]),
                  )
                ],
              ),
            ));
      });
}

void exclamationIcon(BuildContext context, String name) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            color: Color(0xFF000000).withOpacity(0.57),
            height: 500,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 6,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 14),
                    width: double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Report this comment",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Text("Block $name",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                  )
                ],
              ),
            ));
      });
}
