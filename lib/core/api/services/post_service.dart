import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class PostService {
  Future<List<Post>> fetchData({
    int limit = 15,
    int offset = 0,
    String? search,
    int? categoryId,
    String sort = "createdAt-desc",
  }) async {
    Map<String, String> query = {
      "sort": sort,
      "limit": limit.toString(),
      "offset": offset.toString(),
    };

    if (search != null) query["search"] = search;
    if (categoryId != null) query["categoryId"] = categoryId.toString();

    Uri uri = Uri.http(ApiPath.host, ApiPath.getPosts, query);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["posts"].map<Post>((e) => Post.fromMap(e)).toList();
    } else {
      throw Exception("Unable to fetch data");
    }
  }

  Future<List<Post>> fetchDataForMainScreen(
      {int limit = 30, int offset = 0}) async {
    // return List.generate(
    //   10,
    //   (index) => Post(
    //     id: index,
    //     images: [],
    //     title: "qwerty",
    //     content: "Lorem ipsum doler sit",
    //     viewCount: 5,
    //     likeCount: 1,
    //   ),
    // );
    Uri uri = Uri.http(ApiPath.host, ApiPath.getPosts, {
      "limit": limit.toString(),
      "offset": offset.toString(),
      "sort": "createdAt-desc",
      "categoryId": "5",
    });

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["posts"].map<Post>((e) => Post.fromMap(e)).toList();
    } else {
      throw "Unable to fetch data";
    }
  }

  Future<bool> create({
    required List<XFile> images,
    required String title,
    required String content,
    required List<int> regionIds,
  }) async {
    String token = ApiPath.userToken;

    if (token.isEmpty) throw Exception("User not logged in");

    Uri uri = Uri.http(ApiPath.host, ApiPath.createPost);

    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['content'] = content;

    debugPrint("AM2 file start");

    var files = await Future.wait(images.map((e) => e.readAsBytes()));

    debugPrint("AM3 file to byte end");

    for (int i = 0; i < files.length; i++) {
      request.files.add(http.MultipartFile.fromBytes('image-$i', files[i]));
    }

    debugPrint("AMrequest start");

    request.headers['Authorization'] = "Bearer: " + token;

    var response = await request.send();
    debugPrint("AMrequest end");

    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('Something went wrong');
    // return false;
  }
}
