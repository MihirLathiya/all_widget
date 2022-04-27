import 'dart:convert';
import 'package:all_widget/api_routs/api_routs.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  static Future<bool?> signUp({required Map<String, dynamic> reqBody}) async {
    http.Response response = await http.post(
      Uri.parse(ApiRouts.signUpUrl),
      body: reqBody,
    );
    if (response.statusCode == 200) {
      print('===>>>${response.body}');
      var jsonString = jsonDecode(response.body);
      return jsonString['status'];
    }

    return null;
  }
}
