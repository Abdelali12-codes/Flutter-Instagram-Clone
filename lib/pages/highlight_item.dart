import 'package:flutter/material.dart';

import 'constants.dart';

class HighLightItem extends StatelessWidget {
  final String img;
  final String name;
  HighLightItem({this.img, this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 68,
              height: 68,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(68),
                  border: Border.all(
                      style: BorderStyle.solid,
                      width: 2,
                      // color: Color(0xFF9B2282)),
                      color: Colors.grey[500])),
              child: Container(
                width: 65,
                height: 65,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(65),
                    child: Image(image: NetworkImage(img), fit: BoxFit.cover)),
                decoration: BoxDecoration(
                    color: Colors.grey[500],
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.grey[600])),
              )
              // child: Padding(
              //   padding: EdgeInsets.all(3.0),

              // decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //         image: NetworkImage(img), fit: BoxFit.cover)),

              ),
          // ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: 70,
            alignment: Alignment.center,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
