import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstaLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset("assets/icons/instagram-square-color.svg")),
      ),
    );
  }
}
