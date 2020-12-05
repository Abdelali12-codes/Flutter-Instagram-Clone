import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/profile.dart';
import 'package:flutter_instagram_clone/pages/profile_user.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/resources/firebase_methods.dart';
// import 'package:flutter_instagram_clone/resources/firebase_repository.dart';

class SearchAccount extends StatefulWidget {
  @override
  _SearchAccountState createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  FirebaseMethods _methods = FirebaseMethods();
  List<Usermodel> users = List();
  List<Usermodel> filterusers = List();
  String _query = "";

  @override
  void initState() {
    _methods.fetchAllUsers().then((firebaseusers) {
      setState(() {
        users = firebaseusers;
        filterusers = users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = _query.trim().length > 0;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Feather.arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            child: TextField(
              cursorColor: Colors.black,
              cursorWidth: 1,
              onChanged: (query) {
                setState(() {
                  _query = query;
                  filterusers = users
                      .where((user) =>
                          user.name
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          user.username
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .toList();
                });
              },
              autofocus: true,
              decoration: InputDecoration.collapsed(
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Colors.grey[500], fontWeight: FontWeight.bold)),
            ),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey[500],
            unselectedLabelStyle:
                TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            // labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                child: Text("TOP"),
              ),
              Tab(
                child: Text("ACCOUNTS"),
              ),
              Tab(
                child: Text("TAGS"),
              ),
              Tab(
                child: Text("PLACES"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TopTap(
              users: filterusers,
              isEmptyquery: isEmpty,
            ),
            AccountsTap(),
            TagsTap(),
            PlacesTap(),
          ],
        ),
      ),
    );
  }
}

class TopTap extends StatefulWidget {
  final List<Usermodel> users;
  final bool isEmptyquery;
  TopTap({this.users, this.isEmptyquery});
  @override
  _TopTapState createState() => _TopTapState();
}

class _TopTapState extends State<TopTap> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        !widget.isEmptyquery
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                child: Text(
                  "Recent",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Text(""),
        Expanded(
          child: Container(
            child: ListView.builder(
                itemCount: widget.users.length,
                itemBuilder: (context, index) {
                  Usermodel usermodel = widget.users[index];
                  return ListTile(
                    onTap: () {
                      if (usermodel.uid == _auth.currentUser.uid) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                      uid: usermodel.uid,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile(
                                      uid: usermodel.uid,
                                    )));
                      }
                    },
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/spinner.gif",
                            image: usermodel.profilePhoto),
                      ),
                    ),
                    title: SizedBox(
                      width: 200,
                      child: Text(
                        usermodel.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    subtitle: SizedBox(
                      width: 200,
                      child: Text(
                        usermodel.username,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    trailing: !widget.isEmptyquery
                        ? IconButton(
                            icon: Icon(
                              Entypo.cross,
                              color: Colors.grey[500],
                            ),
                            onPressed: () {},
                          )
                        : Text(""),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class AccountsTap extends StatefulWidget {
  @override
  _AccountsTapState createState() => _AccountsTapState();
}

class _AccountsTapState extends State<AccountsTap> {
  FirebaseMethods _methods = FirebaseMethods();
  List<Usermodel> users = List();
  List<Usermodel> filterusers = List();
  @override
  void initState() {
    _methods.fetchAllUsers().then((firebaseusers) {
      setState(() {
        users = firebaseusers;
        filterusers = users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TagsTap extends StatefulWidget {
  @override
  _TagsTapState createState() => _TagsTapState();
}

class _TagsTapState extends State<TagsTap> {
  FirebaseMethods _methods = FirebaseMethods();
  List<Usermodel> users = List();
  List<Usermodel> filterusers = List();
  @override
  void initState() {
    _methods.fetchAllUsers().then((firebaseusers) {
      setState(() {
        users = firebaseusers;
        filterusers = users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PlacesTap extends StatefulWidget {
  @override
  _PlacesTapState createState() => _PlacesTapState();
}

class _PlacesTapState extends State<PlacesTap> {
  FirebaseMethods _methods = FirebaseMethods();
  List<Usermodel> users = List();
  List<Usermodel> filterusers = List();
  @override
  void initState() {
    _methods.fetchAllUsers().then((firebaseusers) {
      setState(() {
        users = firebaseusers;
        filterusers = users;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
