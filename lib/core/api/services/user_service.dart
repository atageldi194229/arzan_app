import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class UserService {
  Future<List<UserModel>> getOfficials({
    int limit = 15,
    int offset = 0,
    String? search,
    String? sort = "createdAt-desc", // "username-asc"
    String? filter = "no-users",
    int? categoryId,
    int? regionId,
  }) async {
    Map<String, String> query = {
      "limit": limit.toString(),
      "offset": offset.toString(),
      if (sort != null) "sort": sort,
      if (filter != null) "filter": filter,
      if (search != null) "search": search,
      if (categoryId != null) "categoryId": categoryId.toString(),
      if (regionId != null) "regionId": regionId.toString(),
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.getUsers, query);

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: " + ApiPath.userToken,
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      return parsed["users"]
          .map<UserModel>((e) => UserModel.fromMap(e))
          .toList();
    }

    throw Exception("Unable to fetch data");
  }
}
