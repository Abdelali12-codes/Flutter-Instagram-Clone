import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/pages/story.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<String> list = List.generate(30, (index) {
    return "item$index";
  });
  List<Story> _stories = [
    Story(
        "https://images.pexels.com/photos/532220/pexels-photo-532220.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/936229/pexels-photo-936229.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/1097456/pexels-photo-1097456.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/1124724/pexels-photo-1124724.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/573299/pexels-photo-573299.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/756453/pexels-photo-756453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/937481/pexels-photo-937481.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
        "abdelali.codes"),
    Story(
        "https://images.pexels.com/photos/412840/pexels-photo-412840.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
        "abdelali.codes")
  ];
  final _key = GlobalKey<ScaffoldState>();
  bool swipedright = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Activity",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: _stories.length,
          itemBuilder: (context, index) {
            final item = list.elementAt(index);
            return Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: Dismissible(
                // confirmDismiss: () async {},
                key: Key(item),
                secondaryBackground: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: swipedright ? Colors.green : Colors.amber,
                  // color: Colors.green,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          child: Icon(Icons.archive),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: Icon(Icons.call),
                          alignment: Alignment.centerRight,
                        )
                      ]),
                ),
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: swipedright ? Colors.green : Colors.amber,
                  // color: Colors.green,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          child: Icon(Icons.archive),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          child: Icon(Icons.call),
                          alignment: Alignment.centerRight,
                        )
                      ]),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(_stories[index].image),
                  ),
                  title: Text(list[index]),
                ),
                onDismissed: (direction) {
                  setState(() {
                    list.removeAt(index);
                  });
                  if (direction == DismissDirection.startToEnd) {
                    setState(() {
                      swipedright = true;
                    });
                    _key.currentState
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("1 converstaion archived"),
                            FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      )));
                  }
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      swipedright = false;
                    });
                    _key.currentState
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("1 converstaion archived"),
                            FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      )));
                  }
                },
              ),
            );
          },
          // separatorBuilder: (context, index) {
          //   return Divider(
          //     indent: 80,
          //   );
          // },
        ),
      ),
    );
  }
}
