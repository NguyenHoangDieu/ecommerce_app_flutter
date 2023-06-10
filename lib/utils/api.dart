import 'package:http/http.dart' as http;



class Services{
  static Future<http.Response> doPost(
      String requestUrl, String requestToken, Object? requestBody) async {
    final result = await http.post(Uri.parse(requestUrl),
        headers: {
          "Authorization": "Bearer $requestToken",
          "Content-Type": "application/json"
        },
        body: requestBody);
    return result;
  }

  static Future<http.Response> doGet(
      String requestUrl, String requestToken) async {
    final result = await http.get(Uri.parse(requestUrl), headers: {
      "Authorization": "Bearer $requestToken",
      "Content-Type": "application/json"
    });
    return result;
  }


  static Future<String> getApiLink() async {
    var url = "";
    url = 'http://172.19.201.60:8089';
    return url;
  }
}