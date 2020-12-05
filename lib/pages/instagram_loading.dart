import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InstaLoading extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xffF58529),
      Color(0xffFEDA77),
      Color(0xffDD2A7B),
      Color(0xff8134AF),
      Color(0xff515BD4)
    ],
  ).createShader(Rect.fromLTWH(8, 200.0, 100.0, 0.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Center(
            child: Container(
                width: 50,
                height: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SvgPicture.asset(
                        "assets/icons/instagram-square-color.svg"))),
          ),
          Positioned(
              bottom: 10,
              left: (MediaQuery.of(context).size.width / 2) - 50,
              child: Column(
                children: [
                  Text(
                    "From",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Facebook',
                    style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = linearGradient),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
