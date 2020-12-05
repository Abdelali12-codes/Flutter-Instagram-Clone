import 'package:flutter/widgets.dart';
import '../models/user.dart';
import '../resources/firebase_repository.dart';

class UserProvider with ChangeNotifier {
  Usermodel _user;

  FirebaseRepository _firebaseRepository = FirebaseRepository();

  Usermodel get getUser => _user;

  void refreshUser() async {
    Usermodel user = await _firebaseRepository.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
