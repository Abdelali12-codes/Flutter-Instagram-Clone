import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> options = <String>[
    "Actor",
    "Architectural Designser",
    "Artist",
    "Athlete",
    "Author",
    "Blogger",
    "Chef",
    "Coach",
    "Comedien",
    "Concert Tour",
    "Dancer",
    "Designer",
    "Digital Creator",
    "DJ",
    "Editor",
    "Entrepreneur",
    "Fashion Designer",
    "Fashion Model",
    "Film Director",
    "Fitness Model",
    "Fitness Trainer",
    "Gamer",
    "Gaming Video Creator",
    "Government Official",
    "Graphic Designer",
    "Interior Design Studio"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
          width: 100,
          child: Text(
            "Categorie",
            style: TextStyle(color: Colors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: IconButton(
          icon: Icon(Feather.arrow_left),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, 'value');
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Select a Category",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Choose a Category that best describes what you do. You'll have the option to display or hide this on your profile",
                    softWrap: true,
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // the search bar container
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.grey[400],
                              width: 2)),
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Feather.search, color: Colors.grey[500]),
                          label: Text(
                            "Search Categories",
                            style: TextStyle(color: Colors.grey[500]),
                          )),
                    ),
                    // the list of choices

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                // color: Colors.red,
                                // height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(options[index]),
                                        onTap: () {
                                          Navigator.pop(
                                              context, options[index]);
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
