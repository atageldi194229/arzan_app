import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';

class MainService {
  Future<dynamic> fetchData() async {
    Uri uri = Uri.http(ApiPath.host, ApiPath.getMainData);

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      return parsed;
    }
  }
}
