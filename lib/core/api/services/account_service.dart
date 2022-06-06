import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tm/core/api/models/count_and_list_model.dart';
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

  Future<CountAndListModel<UserModel>> getFollowings({
    required int userId,
    int limit = 15,
    int offset = 0,
  }) async {
    var queryParameters = <String, String>{
      "limit": limit.toString(),
      "offset": offset.toString(),
    };

    Uri uri = Uri.http(
      ApiPath.host,
      ApiPath.getFollowings.replaceAll(":userId", userId.toString()),
      queryParameters,
    );

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return CountAndListModel(
        count: parsed['count'],
        list: List.from(parsed['users'])
            .map((e) => UserModel.fromMap(e))
            .toList(),
      );
    }

    // other way
    throw Exception("Unable to fetch data");
  }

  Future<CountAndListModel<UserModel>> getFollowers({
    required int userId,
    int limit = 15,
    int offset = 0,
  }) async {
    var queryParameters = <String, String>{
      "limit": limit.toString(),
      "offset": offset.toString(),
    };

    Uri uri = Uri.http(
      ApiPath.host,
      ApiPath.getFollowers.replaceAll(":userId", userId.toString()),
      queryParameters,
    );

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return CountAndListModel(
        count: parsed['count'],
        list: List.from(parsed['users'])
            .map((e) => UserModel.fromMap(e))
            .toList(),
      );
    }

    // other way
    throw Exception("Unable to fetch data");
  }

  Future<bool> update({
    required int id,
    XFile? image,
    String? username,
    String? about,
    int? regionId,
    String? phoneNumber,
    List<XFile>? banners,
  }) async {
    String token = ApiPath.userToken;

    if (token.isEmpty) throw Exception("User not logged in");

    Uri uri = Uri.http(
      ApiPath.host,
      '${ApiPath.getAccount}$id',
    );

    var request = http.MultipartRequest('PUT', uri);

    if (username != null) request.fields['username'] = username;
    if (regionId != null) request.fields['regions'] = "$regionId";
    if (about != null) request.fields['about'] = about;
    if (phoneNumber != null) request.fields['phoneNumber'] = phoneNumber;
    if (image != null) {
      var imageAsBytes = await image.readAsBytes();
      request.files.add(http.MultipartFile.fromBytes('image', imageAsBytes));
    }

    if (banners!.isEmpty) {
      var files = await Future.wait(banners.map((e) => e.readAsBytes()));
      print('value image true');

      for (int i = 0; i < files.length; i++) {
        request.files.add(http.MultipartFile.fromBytes('banners-$i', files[i]));
        print('value image' + i.toString());
      }
    }
    request.headers['Authorization'] = "Bearer: $token";

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
