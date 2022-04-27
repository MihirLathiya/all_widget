import 'dart:convert';
import '../api_routs/api_routs.dart';
import '../model/mack_up_model.dart';
import 'package:http/http.dart' as http;

class MackUpService {
  static Future<List<MackUpModel>?> mackUpService() async {
    http.Response response = await http.get(
      Uri.parse(ApiRouts.mackUpUrl),
    );
    if (response.statusCode == 200) {
      print('===>>${jsonDecode(response.body)}');
      return mackUpModelFromJson(response.body);
    }
    return null;
  }
}
