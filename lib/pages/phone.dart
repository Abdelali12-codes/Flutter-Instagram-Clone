import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Phone extends StatefulWidget {
  final String phone_number;
  Phone({this.phone_number});
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Phone",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Feather.arrow_left),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, '0678481161');
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
      body: Center(
        child: Text(widget.phone_number),
      ),
    );
  }
}
