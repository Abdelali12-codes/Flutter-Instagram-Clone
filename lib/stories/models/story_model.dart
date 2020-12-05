import 'package:meta/meta.dart';
import 'package:flutter_instagram_clone/stories/models/user_model.dart';

enum MediaType { image, video }

class Story {
  final String url;
  final MediaType media;
  final Duration duration;

  Story({
    @required this.url,
    @required this.media,
    @required this.duration,
  });
}
