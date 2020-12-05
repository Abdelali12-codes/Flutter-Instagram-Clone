import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/chat.dart';
// import 'package:flutter_instagram_clone/models/room.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseMethods firebaseMethods = FirebaseMethods();
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Usermodel> rooms = List();
  List<Usermodel> filterrooms = List();
  String query = "";
  @override
  void initState() {
    super.initState();

    firebaseMethods.fetchAllRooms().then((firebaserooms) {
      setState(() {
        rooms = firebaserooms;
        filterrooms = rooms;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Feather.arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, 'change');
          },
        ),
        title: Container(
          child: TextField(
            autofocus: true,
            onChanged: (quer) {
              setState(() {
                query = quer;
                filterrooms = rooms
                    .where((room) =>
                        room.name.toLowerCase().contains(quer.toLowerCase()) ||
                        room.username
                            .toLowerCase()
                            .contains(quer.toLowerCase()))
                    .toList();
              });
            },
            cursorColor: Colors.green[500],
            decoration: InputDecoration.collapsed(
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Colors.grey[500], fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: query.trim().length > 0
              ? Column(
                  children: filterrooms.map((room) {
                    return ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: FadeInImage.assetNetwork(
                            image: room.profilePhoto,
                            placeholder: "assets/images/spinner.gif",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(room.name),
                      subtitle: Text(room.username),
                      onTap: () {},
                    );
                  }).toList(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        "Suggested",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(
                      children: filterrooms.map(
                        (room) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.assetNetwork(
                                  image: room.profilePhoto,
                                  placeholder: "assets/images/spinner.gif",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(room.name),
                            subtitle: Text(room.username),
                            onTap: () async {
                              QuerySnapshot roomsid = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .doc(_auth.currentUser.uid)
                                  .collection("rooms")
                                  .where("with", isEqualTo: room.uid)
                                  .get();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat(
                                            username: room.username,
                                            fullName: room.name,
                                            image: room.profilePhoto,
                                            receiverid: room.uid,
                                            roomId: roomsid.docs[0].id,
                                          )));
                            },
                          );
                        },
                      ).toList(),
                    )
                  ],
                )),
    );
  }
}
