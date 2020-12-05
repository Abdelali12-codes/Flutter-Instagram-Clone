import 'package:flutter/widgets.dart';
import 'package:flutter_instagram_clone/models/tag_user.dart';

class TagProvider with ChangeNotifier {
  TagUser tagUser = TagUser(
      userid: "",
      username: "",
      commentid: "",
      isreplay: false,
      iscomment: false);

  TagUser get getUser => tagUser;
  void refresh({
    String userid,
    String username,
    String commentid,
  }) {
    tagUser = TagUser(
        userid: userid,
        username: username,
        commentid: commentid,
        isreplay: true,
        iscomment: true,
        tagwritten: false);
    notifyListeners();
  }

  void delete() {
    tagUser = TagUser(
        userid: "",
        username: "",
        commentid: "",
        isreplay: false,
        iscomment: false,
        tagwritten: true);

    notifyListeners();
  }

  void tagwritten() {
    tagUser = TagUser(
        userid: "",
        username: "",
        commentid: "",
        isreplay: true,
        iscomment: true,
        tagwritten: true);
    notifyListeners();
  }
}
