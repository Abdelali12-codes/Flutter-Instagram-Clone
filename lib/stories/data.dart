import 'package:flutter_instagram_clone/stories/models/story_model.dart';
import 'package:flutter_instagram_clone/stories/models/user_model.dart';

// final User user = User(
//   name: 'John Doe',
//   profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
// );
final List<Story> stories = [
  Story(
    url:
        'https://images.pexels.com/photos/1576937/pexels-photo-1576937.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    media: MediaType.image,
    duration: const Duration(seconds: 10),
  ),
  Story(
    url:
        'https://images.pexels.com/photos/801885/pexels-photo-801885.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
  ),
  Story(
    url:
        'https://images.pexels.com/photos/842548/pexels-photo-842548.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
  ),
  // Story(
  //   url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
  //   media: MediaType.image,
  //   duration: const Duration(seconds: 7),
  // ),
  // Story(
  //   url:
  //       'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
  //   media: MediaType.video,
  //   duration: const Duration(seconds: 0),
  // ),

  // Story(
  //   url:
  //       'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
  //   media: MediaType.video,
  //   duration: const Duration(seconds: 0),
  // ),
  // Story(
  //   url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
  //   media: MediaType.image,
  //   duration: const Duration(seconds: 8),
  // ),
];
