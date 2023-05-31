import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  static String baseUrl = "https://lime-calm-katydid.cyclic.app";

  static Future<dynamic> get(String endpoints) async {
    Uri uri = Uri.parse(baseUrl + endpoints);
    var res = await http.get(uri);
    if (res.statusCode == 200 || res.statusCode == 201) {
      print(res.statusCode);
      return json.decode(res.body);
    }
    print(res.statusCode);
    print(res.body);
  }

  static Future<dynamic> post(
    String endpoints,
    Map<String, String> userData,
  ) async {
    Uri uri = Uri.parse(baseUrl + endpoints);
    var res = await http.post(uri,
        body: json.encode(userData),
        headers: {"Content-type": "application/json"});
    if (res.statusCode == 200 || res.statusCode == 201) {
      print(res.body);
    } else {
      print("not saved");
    }
  }
}
