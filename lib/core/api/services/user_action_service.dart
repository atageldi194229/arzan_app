import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class UserActionService {
  Future<bool> createUserAction(UserAction userAction) async {
    Uri uri = Uri.http(ApiPath.host, ApiPath.userActions);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer: ${ApiPath.userToken}',
      },
      body: jsonEncode(userAction.toMap()),
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      if (parsed["success"] is bool) return parsed["success"];
      return false;
    } else {
      throw "Unable to fetch data";
    }
  }
}
