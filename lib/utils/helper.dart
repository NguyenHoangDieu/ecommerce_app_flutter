import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../state_maneger/user_changeNotifier.dart';

class Helper{
  static Future<String> getUserPrefs({String key = 'user'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString(key) ?? "";
    return user;
  }
  static Future<User> getCurrentUser() async {
    var user = User();
    var userPref = await getUserPrefs();
    if (userPref.isNotEmpty) {
      var decoded = jsonDecode(userPref) as Map<String, dynamic>;
      user = User.fromLocalCache(decoded);
    }
    return user;
  }

  static Future<bool> removePrefsByKey({String key = 'user'}) async {
    var pref = await SharedPreferences.getInstance();
    var result = await pref.remove(key);
    return result;
  }

  static onSignOut(BuildContext context) async {
    await Helper.removePrefsByKey().then((result) {
      //clear data
      // Provider.of<UserChangeNotifier>(context, listen: false).clearUser();

      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    });
  }
}