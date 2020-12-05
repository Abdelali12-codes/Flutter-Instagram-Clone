import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullPhoto extends StatefulWidget {
  final String url;
  FullPhoto({Key key, @required this.url}) : super(key: key);
  @override
  _FullPhotoState createState() => _FullPhotoState();
}

class _FullPhotoState extends State<FullPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: BouncingScrollPhysics(),
                builder: (BuildContext context, index) {
                  return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.url),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 1.5);
                },
                itemCount: 1,
                loadingBuilder: (context, event) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20,
                    child: CircularProgressIndicator(
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes,
                    ),
                  ),
                ),
                backgroundDecoration: BoxDecoration(color: Colors.black),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
