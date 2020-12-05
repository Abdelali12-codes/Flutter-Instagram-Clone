import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  AnimationController animationController;
  Animation animation;
  Animation rotationAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'New Post',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Feather.arrow_left, color: Colors.black),
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(left: 6),
              width: 100,
              // color: Colors.red,
              alignment: Alignment.center,
              child: Text('Share',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            )
          ],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                  right: 30,
                  bottom: 30,
                  child: Stack(children: [
                    Transform.translate(
                      offset: Offset.fromDirection(
                          getRadiansFromDegree(270), animation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.blue,
                          width: 60,
                          height: 60,
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onClick: () {},
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          getRadiansFromDegree(225), animation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.black,
                          width: 60,
                          height: 60,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onClick: () {},
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          getRadiansFromDegree(180), animation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: CircularButton(
                          color: Colors.orangeAccent,
                          width: 60,
                          height: 60,
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          onClick: () {},
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value)),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Colors.red,
                        width: 60,
                        height: 60,
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onClick: () {
                          if (animationController.isCompleted) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }
                        },
                      ),
                    ),
                  ]))
            ],
          ),
        ));
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;
  CircularButton(
      {this.width, this.height, this.color, this.icon, this.onClick});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconButton(
        icon: icon,
        onPressed: onClick,
        enableFeedback: true,
      ),
    );
  }
}
