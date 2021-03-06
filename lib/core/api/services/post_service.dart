import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tm/core/api/models/count_and_list_model.dart';
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class PostService {
  Future<List<PostModel>> fetchData({
    int limit = 15,
    int offset = 0,
    String? search,
    int? categoryId,
    int? regionId,
    String sort = "createdAt-desc",
  }) async {
    Map<String, String> query = {
      "sort": sort,
      "limit": limit.toString(),
      "offset": offset.toString(),
      if (search != null) "search": search,
      if (regionId != null) "regionId": "$regionId",
      if (categoryId != null) "categoryId": "$categoryId",
    };

    Uri uri = Uri.http(ApiPath.host, ApiPath.getPosts, query);

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["posts"]
          .map<PostModel>((e) => PostModel.fromMap(e))
          .toList();
    } else {
      throw Exception("Unable to fetch data");
    }
  }

  Future<List<PostModel>> fetchDataForMainScreen(
      {int limit = 30, int offset = 0, int? regionId}) async {
    Uri uri = Uri.http(ApiPath.host, ApiPath.getPosts, <String, String>{
      "limit": "$limit",
      "offset": "$offset",
      "sort": "createdAt-desc",
      // "categoryId": "5",
      if (regionId != null) "regionId": "$regionId",
    });

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["posts"]
          .map<PostModel>((e) => PostModel.fromMap(e))
          .toList();
    } else {
      throw Exception("Unable to fetch data");
    }
  }

  Future<bool> create({
    required List<XFile> images,
    required String title,
    required String content,
    required List<int> regionIds,
    required String contact,
  }) async {
    String token = ApiPath.userToken;

    if (token.isEmpty) throw Exception("User not logged in");

    Uri uri = Uri.http(ApiPath.host, ApiPath.createPost);

    var request = http.MultipartRequest('POST', uri)
      ..fields['contacts'] = contact
      ..fields['title'] = title
      ..fields['content'] = content;

    Map<String, String> regions = {
      for (var i = 0; i < regionIds.length; i++)
        'regions[$i]': "${regionIds[i]}"
    };

    request.fields.addAll({
      ...regions,
    });

    var files = await Future.wait(images.map((e) => e.readAsBytes()));

    for (int i = 0; i < files.length; i++) {
      request.files.add(http.MultipartFile.fromBytes('image-$i', files[i]));
    }

    request.headers['Authorization'] = "Bearer: $token";

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('Something went wrong');
  }

  Future<CountAndListModel<PostModel>> getUserPosts({
    required int userId,
    int limit = 15,
    int offset = 0,
    String? search,
    String sort = "createdAt-desc",
    String filter = "confirmed",
  }) async {
    var query = <String, String>{
      "sort": sort,
      "filter": filter,
      "limit": "$limit",
      "offset": "$offset",
      if (search != null) "search": search,
    };

    Uri uri = Uri.http(
      ApiPath.host,
      ApiPath.getUserPosts.replaceAll(":userId", "$userId"),
      query,
    );

    var response = await http.get(
      uri,
      headers: <String, String>{
        "Authorization": "Bearer: ${ApiPath.userToken}",
      },
    );

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      int count = 0;
      if (parsed['count'] is String) count = int.tryParse(parsed['count']) ?? 0;
      if (parsed['count'] is int) count = parsed['count'];

      return CountAndListModel(
        count: count,
        list: List.from(parsed["posts"])
            .map<PostModel>((e) => PostModel.fromMap(e))
            .toList(),
      );
    }

    throw Exception("Unable to fetch data");
  }
}
