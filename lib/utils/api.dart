import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Services{

  static Future<http.Response> doPost(String requestUrl, String requestToken, Object? requestBody) async {
    final result = await http.post(Uri.parse(requestUrl),
        headers: {
          "Authorization": "Bearer $requestToken",
          "Content-Type": "application/json"
        },
        body: requestBody);
    return result;
  }

  static Future<http.Response> doGet(String requestUrl, String requestToken) async {
    final result = await http.get(Uri.parse(requestUrl), headers: {
      "Authorization": "Bearer $requestToken",
      "Content-Type": "application/json"
    });
    return result;
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }
  static Future<String> getApiLink() async {
    var url = "";
    url = 'http://www.hoangdieudev11.somee.com';
    return url;
  }
}