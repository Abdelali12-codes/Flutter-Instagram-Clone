import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/Name.dart';
import 'package:flutter_instagram_clone/pages/bio.dart';
import 'package:flutter_instagram_clone/pages/category.dart';
import 'package:flutter_instagram_clone/pages/email.dart';
import 'package:flutter_instagram_clone/pages/gender.dart';
import 'package:flutter_instagram_clone/pages/phone.dart';
import 'package:flutter_instagram_clone/pages/username.dart';
import 'package:flutter_instagram_clone/pages/web.dart';
import 'package:flutter_instagram_clone/screens/loading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class LoginProfile extends StatefulWidget {
  @override
  _LoginProfileState createState() => _LoginProfileState();
}

class _LoginProfileState extends State<LoginProfile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseMessaging _messaging = FirebaseMessaging();
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  final _usernameController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _website = TextEditingController();
  final _bio = TextEditingController();
  final _email = TextEditingController();
  final _phone_number = TextEditingController();
  // final _category = TextEditingController();
  String _category = '';
  final _gender = TextEditingController();
  File _image;
  String file;
  String token = '';
  String category = 'deault';
  bool isloading = false;

  @override
  void initState() {
    _usernameController.text = 'abdelali';
    _fullnameController.text = 'jad';
    _website.text = 'jadelmoua@gmail.com';
    _bio.text = 'full stuck dev';
    _email.text = 'jadelmoula@gmail.com';
    _phone_number.text = '0662607275';
    _gender.text = 'Male';

    // _configuration();
    super.initState();
  }

  @override
  void dispose() {
    _website.dispose();
    _bio.dispose();
    _usernameController.dispose();
    _fullnameController.dispose();
    _email.dispose();
    _phone_number.dispose();
    _gender.dispose();
    super.dispose();
  }

  // void _configuration() async {
  //   _messaging.getToken().then((token) {
  //     print('the token is $token');
  //   });

  //   _messaging.configure(onMessage: (Map<String, dynamic> message) async {
  //     print("Onmessage $message");
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print("on Launch $message");
  //   }, onResume: (Map<String, dynamic> message) async {
  //     print('OnResume $message');
  //   });
  // }

  Future _getImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false));
    setState(() {
      _image = croppedFile;
      file = pickedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isloading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Login_Profile',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Feather.check),
                  iconSize: 25,
                  color: Colors.blue,
                  // save button
                  onPressed: () async {
                    if (_image != null) {
                      setState(() {
                        isloading = true;
                      });
                      // StorageReference firebaseStorage =
                      //     FirebaseStorage().ref().child(file.split("/").last);
                      // StorageUploadTask uploadTask =
                      //     firebaseStorage.putFile(_image);
                      // StorageTaskSnapshot storageTaskSnapshot =
                      //     await uploadTask.onComplete;
                      // String url =
                      //     await storageTaskSnapshot.ref.getDownloadURL();

                      try {
                        await _auth.currentUser.updateProfile(
                            displayName: _fullnameController.text.trim(),
                            photoURL: "url");

                        users.doc(_auth.currentUser.uid).update({
                          'username': _usernameController.text.trim(),
                          'fullname': _fullnameController.text.trim(),
                          'photourl': " url" ?? '',
                          'blockedby': [],
                          'usersblocked': [],
                          'callrefused': false,
                          'followers': [],
                          'following': [],
                          'postsliked': [],
                          'token': "",
                          'phone': _phone_number.text.trim(),
                          "category": _category,
                          "gender": _gender.text.trim(),
                          "website": "",
                          'userRole': true,
                        });
                      } catch (e) {
                        setState(() {
                          isloading = false;
                        });
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.message),
                              );
                            });
                      }
                    }
                  },
                )
              ],
            ),
            body: Builder(
              builder: (BuildContext context) => Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.width,
                            height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        // backgroundColor: Colors.amber,
                                        child: _image != null
                                            ? Image.file(
                                                _image,
                                                fit: BoxFit.cover,
                                              )
                                            : Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    "assets/images/download.jpg")),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _getImage();
                                      },
                                      child: Container(
                                        child: Text(
                                          'Change Profile Photo',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          // the user first infos
                          Container(
                            width: size.width,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("hello");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Name()));
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                      readOnly: true,
                                      enabled: false,
                                      controller: _fullnameController,
                                      decoration: InputDecoration(
                                          hintText: 'Your fullName....',
                                          labelText: 'Name',
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserName()));
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TextField(
                                        readOnly: true,
                                        enabled: false,
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          hintText: 'Your userName....',
                                          labelText: 'UserName',
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contetx) => Email()));
                                  },
                                  child: Container(
                                    width: size.width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Web()));
                                          },
                                          child: Container(
                                            child: TextField(
                                              readOnly: true,
                                              enabled: false,
                                              controller: _website,
                                              decoration: InputDecoration(
                                                  hintText: 'WebSite....',
                                                  labelText: 'WebSite',
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Bio()));
                                          },
                                          child: Container(
                                            child: TextField(
                                              controller: _bio,
                                              readOnly: true,
                                              enabled: false,
                                              enableInteractiveSelection: false,
                                              decoration: InputDecoration(
                                                  hintText: 'bio...',
                                                  labelText: 'Bio',
                                                  labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // second column
                      SizedBox(
                        height: 30,
                      ),
                      Divider(
                        height: 3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: size.width,
                            // color: Colors.blue,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Profile Information",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                // the last  column of he user informations
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Page",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Connect or Create',
                                            style: TextStyle(
                                                color: Color(0xFF9E9E9E),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          dynamic result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Category()));
                                          setState(() {
                                            _category = result;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Category",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              category,
                                              style: TextStyle(
                                                  color: Color(0xFF9E9E9E),
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Contact Options",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Action Buttons",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'None Action',
                                            style: TextStyle(
                                                color: Color(0xFF9E9E9E),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Profile Display",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Contacts Hidden',
                                            style: TextStyle(
                                                color: Color(0xFF9E9E9E),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Divider(
                                  height: 3,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  "Admin Contact info",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    dynamic result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Email()));
                                    setState(() {
                                      _email.text = result;
                                    });
                                  },
                                  child: Container(
                                    child: TextField(
                                      controller: _email,
                                      readOnly: true,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: 'email address',
                                          labelText: 'Email Address',
                                          labelStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 3,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    dynamic result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Phone(
                                                  phone_number:
                                                      _phone_number.text,
                                                )));
                                    setState(() {
                                      _phone_number.text = result;
                                    });
                                  },
                                  child: Container(
                                    child: TextField(
                                      controller: _phone_number,
                                      readOnly: true,
                                      enabled: false,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your phone number',
                                          labelText: 'Phone number',
                                          labelStyle: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    dynamic result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Gender(
                                                  gender: _gender.text,
                                                )));
                                    setState(() {
                                      if (result != "") {
                                        _gender.text = result;
                                      }
                                    });
                                  },
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: TextField(
                                            decoration: InputDecoration(
                                                labelText: "gender",
                                                labelStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            controller: _gender,
                                            enabled: false,
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
