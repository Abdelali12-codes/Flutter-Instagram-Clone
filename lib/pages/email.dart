import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Email extends StatefulWidget {
  String email;
  Email({this.email});
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _email = TextEditingController();
  @override
  void initState() {
    _email.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Email",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Entypo.cross),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, _email.text);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Feather.check),
            color: Colors.blue,
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _email,
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                  EvilIcons.envelope,
                  size: 40,
                  color: Colors.black,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
