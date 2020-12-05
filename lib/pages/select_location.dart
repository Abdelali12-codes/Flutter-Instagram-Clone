// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:flutter_instagram_clone/badges/search_bloc.dart';
// import 'package:place_plugin/place.dart';

// class SelectLocation extends StatefulWidget {
//   @override
//   _SelectLocationState createState() => _SelectLocationState();
// }

// class _SelectLocationState extends State<SelectLocation> {
//   bool _isloading = false;
//   var searchBloc = SearchBloc();
//   String googleMapApikey = "AIzaSyB7blWXEbyI8QDXc4ISIQq6pAe7-SRUlR8";
//   String apiKey = "AIzaSyDVjHP2ucqJzvl62OzDwnrUQFPYU-djt2s";
//   List<String> list = List.generate(30, (index) => "Casablance $index");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: Text(
//           "Select a Location",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Entypo.cross,
//             color: Colors.black,
//             size: 27,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           _isloading
//               ? Container(
//                   // color: Colors.red,
//                   height: 10,
//                   padding: EdgeInsets.all(17),
//                   width: 56,
//                   child: Container(
//                       child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
//                   )))
//               : IconButton(
//                   icon: Icon(
//                     Ionicons.ios_refresh,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {})
//         ],
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: TextField(
//                   cursorColor: Colors.green[400],
//                   onChanged: (value) {
//                     searchBloc.searchPlace(value);
//                     setState(() {
//                       _isloading = true;
//                     });
//                   },
//                   decoration: InputDecoration(
//                       hintText: "Find a location...",
//                       hintStyle: TextStyle(color: Colors.grey[500]),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: Colors.grey[500],
//                       )),
//                 ),
//               ),
//               StreamBuilder(
//                   stream: searchBloc.searchStream,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData && snapshot.data != null) {
//                       // setState(() {
//                       //   _isloading = false;
//                       // });
//                       // List<Place> places = snapshot.data;
//                       if (snapshot.data == "searching_") {
//                         return Container(
//                           margin: EdgeInsets.only(top: 10),
//                           height: 454,
//                           child: Center(
//                             child: CupertinoActivityIndicator(),
//                           ),
//                         );
//                       }
//                       print(snapshot.data);
//                       List<Place> places = snapshot.data;
//                       return Container(
//                         margin: EdgeInsets.only(top: 10),
//                         height: 454,
//                         child: ListView.separated(
//                           itemCount: 20,
//                           itemBuilder: (context, index) {
//                             Place place = places.elementAt(index);
//                             return ListTile(
//                               title: Text(place.name),
//                               subtitle: Text(place.address),
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return Divider();
//                           },
//                         ),
//                       );
//                     } else {
//                       return Container(
//                         margin: EdgeInsets.only(top: 10),
//                         // color: Colors.red,
//                         height: 454,
//                         child: Center(
//                           child: Text('No Data Exist'),
//                         ),
//                       );
//                     }
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
