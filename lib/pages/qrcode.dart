// import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ScanPage extends StatefulWidget {
//   @override
//   _ScanPageState createState() => _ScanPageState();
// }

// class _ScanPageState extends State<ScanPage> {
//   String qrcoderesult = 'Not yet Scanned';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Scanner"),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Result',
//               style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               qrcoderesult,
//               style: TextStyle(fontSize: 20.0),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             FlatButton(
//               padding: EdgeInsets.all(15.0),
//               onPressed: () async {
//                 var codeScanner = await BarcodeScanner.scan();
//                 print(codeScanner.toString());
//                 // if(await canLaunch(codeScanner.toString()){

//                 // }
//                 setState(() {
//                   qrcoderesult = codeScanner.toString();
//                 });
//               },
//               child: Text(
//                 "Open Scanner",
//                 style:
//                     TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//               ),
//               shape: RoundedRectangleBorder(
//                   side: BorderSide(color: Colors.blue, width: 3.0),
//                   borderRadius: BorderRadius.circular(20.0)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
