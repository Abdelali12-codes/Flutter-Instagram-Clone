import 'package:flutter/material.dart';

class OnlinIndicator extends StatefulWidget {
  final String photourl;
  OnlinIndicator({this.photourl});
  @override
  _OnlinIndicatorState createState() => _OnlinIndicatorState();
}

class _OnlinIndicatorState extends State<OnlinIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/spinner.gif",
                fit: BoxFit.cover,
                image: widget.photourl,
              ),
            ),
          ),
          Positioned(
            bottom: -2,
            right: 1,
            child: Container(
              width: 20,
              height: 20,
              padding: EdgeInsets.all(3),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                height: 20,
                width: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OnlinIndicatorChat extends StatefulWidget {
  final String photourl;
  OnlinIndicatorChat({this.photourl});
  @override
  _OnlinIndicatorChatState createState() => _OnlinIndicatorChatState();
}

class _OnlinIndicatorChatState extends State<OnlinIndicatorChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/spinner.gif",
                fit: BoxFit.cover,
                image: widget.photourl,
              ),
            ),
          ),
          Positioned(
            bottom: -2,
            right: 1,
            child: Container(
              width: 15,
              height: 15,
              padding: EdgeInsets.all(3),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                height: 15,
                width: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
