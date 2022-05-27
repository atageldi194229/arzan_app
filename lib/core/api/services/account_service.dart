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
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      if (parsed["success"] is bool && parsed["success"] == true) {
        return UserModel.fromMap(parsed["user"]);
      }
    }

    // other way
    throw Exception("Unable to fetch data");
  }

  Future<List<int>> fetchFollowingIdList() async {
    Uri uri = Uri.http(ApiPath.host, ApiPath.userFollowings);

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return List<Map>.from(parsed['followings'])
          .map<int>((e) => e['userId'])
          .toList();
    }

    // other way
    throw Exception("Unable to fetch data");
  }

  Future<bool> follow({
    required int userId,
  }) async {
    Uri uri = Uri.http(ApiPath.host,
        ApiPath.followUser.replaceFirst(':userId', userId.toString()));

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> unfollow({
    required int userId,
  }) async {
    Uri uri = Uri.http(ApiPath.host,
        ApiPath.unfollowUser.replaceFirst(':userId', userId.toString()));

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    return response.statusCode == 200;
  }
}
