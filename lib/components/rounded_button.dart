import 'package:flutter_instagram_clone/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  RoundedButton(
      {this.text,
      this.press,
      this.color = kPrimaryColor,
      this.textColor = Colors.white});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Container(
        // borderRadius: BorderRadius.circular(29),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29),
            color: Colors.purple,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0),
                // tileMode: TileMode.repeated,
                colors: [
                  const Color(0xFFfdf497),
                  const Color(0xFFfd5949),
                  Color(0xFFd6249f),
                  Color(0xFF285AEB)
                ])),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          // color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
