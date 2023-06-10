import 'dart:convert';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
class UserProvider{
  static Future<bool> loginAuthenticate(String username, String password) async {
    var result = false;
    final host = await Services.getApiLink();
    final url = "$host/api/Account/Login";
    final data = {'username': username, 'password': password};
    final body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json"
        },
        body: body);
    if (response.isSuccess()) {
      final responseBody = jsonDecode(response.body);
      final responeStatus = responseBody['userMessage'];
      if (responeStatus == 'Login Success') {
        result = true;
      }
    }
    return result;
  }
}