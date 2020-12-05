import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;
  CachedImage({@required this.url});

  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (cpntext, url) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
