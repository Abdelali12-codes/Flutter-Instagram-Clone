// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:flutter/rendering.dart';

// class GeneratePage extends StatefulWidget {
//   @override
//   _GeneratePageState createState() => _GeneratePageState();
// }

// class _GeneratePageState extends State<GeneratePage> {
//   String qrData = "https://instagram-clone-84392.web.app/";
//   final qrdataFeed = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR code Generator'),
//         actions: [],
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Container(
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   QrImage(
//                     //plce where the QR Image will be shown
//                     data: qrData,
//                   ),
//                   SizedBox(
//                     height: 40.0,
//                   ),
//                   Text(
//                     "New QR Link Generator",
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                   TextField(
//                     controller: qrdataFeed,
//                     decoration: InputDecoration(
//                       hintText: "Input your link or data",
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
//                     child: FlatButton(
//                       padding: EdgeInsets.all(15.0),
//                       onPressed: () async {
//                         if (qrdataFeed.text.isEmpty) {
//                           //a little validation for the textfield
//                           setState(() {
//                             qrData = "";
//                           });
//                         } else {
//                           setState(() {
//                             qrData = qrdataFeed.text;
//                           });
//                         }
//                       },
//                       child: Text(
//                         "Generate QR",
//                         style: TextStyle(
//                             color: Colors.blue, fontWeight: FontWeight.bold),
//                       ),
//                       shape: RoundedRectangleBorder(
//                           side: BorderSide(color: Colors.blue, width: 3.0),
//                           borderRadius: BorderRadius.circular(20.0)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
