import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Gender extends StatefulWidget {
  String gender;
  Gender({this.gender});
  @override
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String checked = "";
  void initState() {
    checked = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Gender",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Feather.arrow_left),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context, 'Female');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Feather.check),
            color: Colors.blue,
            onPressed: () {
              Navigator.pop(context, checked);
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Female',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Radio(
                      value: "Female",
                      groupValue: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Male',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    Radio(
                      value: "Male",
                      groupValue: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                        });
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Custom',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    Radio(
                      value: "Custom",
                      groupValue: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                        });
                      },
                    )
                  ],
                ),
                checked == "Custom"
                    ? TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                            hintText: "Your gender",
                            errorText: "the gender field must not be empty"),
                      )
                    : Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Prefer Not to Say',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    Radio(
                      value: "Not Say",
                      groupValue: checked,
                      onChanged: (value) {
                        print('the value is $value');
                        setState(() {
                          checked = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
