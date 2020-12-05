import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/new_post.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File _image;
  PickedFile picked;
  final picker = ImagePicker();
  File croped;
  String file;
  // StorageUploadTask task;
  // StorageTaskSnapshot snapshot;
  // StorageReference storageReference = FirebaseStorage().ref();
  CollectionReference blobs = FirebaseFirestore.instance.collection("blobs");
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
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
          lockAspectRatio: false),
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        // croped = croppedFile;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewPost(
                      photourl: croppedFile,
                    )));
        file = pickedFile.path.split("/").last;
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Select Image',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

// body: Builder(
//   builder: (BuildContext context) => Container(
//     // color: Colors.red,
//     alignment: Alignment.center,
//     child: Column(
//       children: [
//         Container(
//           width: 200,
//           height: 200,
//           child: _image == null
//               ? Text('No image selected')
//               : Image.file(_image),
//         ),
//         RaisedButton(onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => NewPost()));
//         }),
//         RaisedButton(
//           child: Text('upload'),
//           onPressed: () async {
//             if (_image != null) {
//               final StorageReference storageReference =
//                   FirebaseStorage().ref().child(file);
//               final StorageUploadTask uploadTask =
//                   storageReference.putFile(croped);

//               setState(() {
//                 task = uploadTask;
//               });
//               StorageTaskSnapshot storageTaskSnapshot =
//                   await uploadTask.onComplete;

//               String imageUrl =
//                   await storageTaskSnapshot.ref.getDownloadURL();

//               CollectionReference blobs =
//                   FirebaseFirestore.instance.collection("blobs");

//               await blobs.add({
//                 'url': imageUrl,
//                 'time': FieldValue.serverTimestamp(),
//               });
//             }
//             setState(() {
//               _image = null;
//             });
//             print(file);
//           },
//         ),
//         task != null
//             ? (Container(
//                 height: 100,
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.amber,
//                 child: StreamBuilder<StorageTaskEvent>(
//                   stream: task.events,
//                   builder: (context, asyncsnapshot) {
//                     if (asyncsnapshot.hasData) {
//                       final StorageTaskEvent event = asyncsnapshot.data;
//                       final StorageTaskSnapshot snapshot = event.snapshot;
//                       return Text(
//                           "${snapshot.bytesTransferred / snapshot.totalByteCount} bytes sent");
//                     }
//                     return Text('');
//                   },
//                 ),
//               ))
//             : Text(''),
//         Expanded(
//           child: Container(
//               padding: EdgeInsets.only(top: 10),
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: blobs.snapshots(),
//                 builder: (context, snapshot) {
//                   return snapshot.hasData
//                       ? GridView.count(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 2,
//                           mainAxisSpacing: 2,
//                           children: snapshot.data.docs.map((doc) {
//                             return Container(
//                                 child: Image(
//                               image: NetworkImage(doc.data()['url']),
//                               fit: BoxFit.cover,
//                             ));
//                           }).toList())
//                       : Text('');
//                 },
//               )),
//         )
//       ],
//     ),
//   ),
// ),
