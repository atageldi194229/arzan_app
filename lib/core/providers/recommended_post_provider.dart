import 'package:tm/core/api/services/post_service.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

class RecommendedPostProvider with ChangeNotifier {
  late List<models.Post> _posts = <models.Post>[];

  get posts => _posts;

  set posts(value) {
    _posts = value;
    notifyListeners();
  }

  getRecommendedPosts() {
    PostService()
        .fetchData()
        .then((value) => posts = value)
        .catchError((err) {});
  }
}
