import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          // color: Colors.brown,
          color: Color(0xff515BD4),
          size: 50.0,
        ),
      ),
    );
  }
}
