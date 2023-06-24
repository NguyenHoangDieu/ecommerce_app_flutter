import 'dart:convert';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
class UserProvider{
  static Future<User> loginAuthenticate(String username, String password) async {
    var dataUser = User();
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
        var respBody = json.decode(response.body);
        dataUser.id = respBody['id'];
        dataUser.token = respBody['accessToken'];
        dataUser.username = respBody['username'];
        dataUser.password = respBody['password'];
      }
    }
    return dataUser;
  }

  static Future<User> profileUser(int idUser, String token) async {
    User result = User();
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/Account/GetUserInfo?id=$idUser';
    final response = await Services.doGet(requestUrl, token);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      result.id = body['id'];
      result.username = body['username'];
      result.password = body['password'];
      result.hoVaTen = body['hoVaTen'];
      result.token = body['accessToken'];
      result.dienThoai = body['dienThoai'];

    }
    return result;
  }
}