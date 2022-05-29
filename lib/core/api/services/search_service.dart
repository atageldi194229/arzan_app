import 'package:http/http.dart' as http;
import 'dart:convert';
import '../api_path.dart';

class SearchService {
  Future<List<String>> getSuggestions(String search) async {
    Map<String, String> body = {
      "search": search,
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.getSearchSuggestion);

    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return List<String>.from(parsed["suggestions"]);
    } else {
      return <String>[];
    }
  }
}
