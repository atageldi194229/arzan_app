import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/index.dart';
import '../api_path.dart';

class PostService {
  Future<List<Post>> fetchData() async {
    Uri uri = Uri.http(ApiPath.host, ApiPath.getPosts, {
      "limit": "15",
      "sort": "createdAt-desc",
      "categoryId": "1",
    });

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      return parsed["posts"].map<Post>((e) => Post.fromMap(e)).toList();
    } else {
      throw "Unable to fetch data";
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
}
