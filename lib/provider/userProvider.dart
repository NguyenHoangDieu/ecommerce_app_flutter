import 'dart:convert';
import 'dart:ffi';
import 'package:ecommerce_app_flutter/utils/api.dart';
import 'package:ecommerce_app_flutter/utils/common.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
class UserProvider{
  static Future<Map<String, Object>> loginAuthenticate(String username, String password) async {
    var status = false;
    var idUser = 0;
    String token = '';
    Map<String, Object> myData = {
      'status': status,
      'idUser': idUser,
      'token': token
    };
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
      if (response.statusCode == 200) {
        var respBody = json.decode(response.body);
        myData['status'] = respBody['status'];
        var data = respBody['data'];
        myData['idUser'] = data['id'];
        myData['token'] = data['accessToken'];
      }
    }
    return myData;
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

  static Future<User> registerUser(User user) async {
    User result = User();
    final host = await Services.getApiLink();
    final requestUrl = '$host/api/Account/Register';
    final data = {
      'username': user.username,
      'password': user.password,
      'hoVaTen': user.hoVaTen,
      'dienThoai': user.dienThoai
    };
    final bodyRequest = json.encode(data);
    final response = await Services.doPost(requestUrl, '', bodyRequest);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      result.id = body['id'];
      result.username = body['username'];
      result.password = body['password'];
      result.hoVaTen = body['hoVaTen'];
      result.dienThoai = body['dienThoai'];
    }
    return result;
  }
}