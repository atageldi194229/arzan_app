import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class AccountService {
  Future<UserModel> fetchData({
    required int userId,
  }) async {
    Uri uri = Uri.http(ApiPath.host, ApiPath.getAccount + userId.toString());

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: " + ApiPath.userToken,
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      if (parsed["success"] is bool && parsed["success"] == true) {
        return UserModel.fromMap(parsed["user"]);
      }
    }

    // other way
    throw "Unable to fetch data";
  }
}
