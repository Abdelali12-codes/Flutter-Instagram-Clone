import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message.dart';
import '../models/user.dart';
import '../provider/image_upload_provider.dart';
import 'firebase_methods.dart';
import 'package:meta/meta.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();
  Future<User> getCurrentUser() => _firebaseMethods.getCurrretUser();
  Future<UserCredential> signIn() => _firebaseMethods.signIn();
  Future<Usermodel> getCurrentUserDetailsofuid({String uid}) =>
      _firebaseMethods.getUserDetailsofuid(uid: uid);
  Future<bool> authenticateUser(User user) =>
      _firebaseMethods.authenticateUser(user);
  Future<void> fetchAllUsers() => _firebaseMethods.fetchAllUsers();
  Future<Usermodel> getUserDetails() => _firebaseMethods.getUserDetails();
  Future<void> addMessageToDb(
          Message message, Usermodel sender, String roomid) =>
      _firebaseMethods.addMessageToDb(message, sender, roomid);

  Future<String> uploadImageToStorage(File imageFile) =>
      _firebaseMethods.uploadImageToStorage(imageFile);

  void uploadImage(
          {@required File image,
          @required String senderId,
          @required ImageUploadProvider imageUploadProvider,
          @required String roomId}) =>
      _firebaseMethods.uploadImage(
          image, senderId, imageUploadProvider, roomId);
}
