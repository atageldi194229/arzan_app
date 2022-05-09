import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/api/services/user_action_service.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

class HomeScreenProvider extends ChangeNotifier {
  bool isFetching = false;
  final List<models.Post> _posts = [];

  get posts => _posts;

  int limit = 20;

  int offset = 0;

  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  get currentPost => posts[_currentIndex];

  set currentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }

  addAllPosts(List<models.Post> postList) {
    _posts.addAll(postList);
    notifyListeners();
  }

  void fetchPosts() async {
    if (isFetching) return;
    isFetching = true;
    await PostService()
        .fetchDataForMainScreen(limit: limit, offset: offset)
        .then((postList) {
      offset += limit;
      addAllPosts(postList);
    }).catchError((err) {
      isFetching = false;
    });
    isFetching = false;
  }

  void viewPost(models.Post post, {bool listen = true}) {
    post.viewCount++;
    UserActionService()
        .createUserAction(
          models.UserAction(
            id: post.id,
            count: 1,
            type: models.UserActionModel.post,
            action: models.UserActionType.view,
          ),
        )
        .catchError((error) => Future.value(false));
    if (listen) notifyListeners();
  }
}
