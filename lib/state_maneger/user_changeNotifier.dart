import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserChangeNotifier extends ChangeNotifier {
  var isShowTMDT = false;
  User _currentUser = User();

  User get currentUser => _currentUser;

  set currentUser(User newValue) {
    _currentUser = newValue;
  }

  clearUser() {
    _currentUser = User();
  }

  // updateUserAvatar(String newAvatar) {
  //   _currentUser.avatar = newAvatar;
  // }

}