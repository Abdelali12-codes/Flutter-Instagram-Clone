class Blob {
  final String firstName;
  final String lastName;
  final List<String> likedbyId;
  final int likes;
  final String photourl;
  final List<String> savedbyId;
  // time ;
  final String url;
  final List<Comments> comments;

  Blob(
      {this.firstName,
      this.lastName,
      this.likedbyId,
      this.likes,
      this.photourl,
      this.savedbyId,
      this.url,
      this.comments});
}

class Comments {
  final String uid; // the user who commentedt id
  final String comment;
  // time
  Comments({this.uid, this.comment});
}
