import 'package:flutter/material.dart';
import 'text_field_container.dart';
// import 'package:flutter_instagram_clone/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  RoundedPasswordField({Key key, this.onChanged}) : super(key: key);
  @override
  _RoundedPassworFieldState createState() => _RoundedPassworFieldState();
}

class _RoundedPassworFieldState extends State<RoundedPasswordField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: hide,
        onChanged: widget.onChanged,
        // cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                hide ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  hide = !hide;
                });
              },
            ),
            border: InputBorder.none),
      ),
    );
  }
}
