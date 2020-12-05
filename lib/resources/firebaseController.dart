// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class FirebaseController {
  static FirebaseController get instance => FirebaseController();

  Future<String> sendImageToUserInChatRoom(croppedFile, chatID) async {
    try {
      String imageTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = 'chatrooms/$chatID/$imageTimeStamp';
      // final StorageReference storageReference =
      //     FirebaseStorage().ref().child(filePath);
      // final StorageUploadTask uploadTask =
      //     storageReference.putFile(croppedFile);
      // StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      // String result = await storageTaskSnapshot.ref.getDownloadURL();
      return "result";
    } catch (e) {
      print(e.message);
    }
  }
}
