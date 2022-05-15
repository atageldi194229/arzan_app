import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/api/services/user_action_service.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

abstract class PostListProvider extends ChangeNotifier {
  bool isFetching = false;
  final List<models.Post> _posts = [];

  int limit = 20;
  int offset = 0;

  int _currentIndex = 0;

  get posts => _posts;
  get currentIndex => _currentIndex;
  get currentPost => posts[_currentIndex];

  setCurrentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }

  addAllPosts(List<models.Post> postList) {
    _posts.addAll(postList);
    offset += limit;
    notifyListeners();
  }

  loadPosts() async {
    if (isFetching) return;
    isFetching = true;

    try {
      List<models.Post> list = await fetchPosts(limit, offset);
      addAllPosts(list);
    } catch (err) {
      debugPrint(err.toString());
    }

    isFetching = false;
  }

  Future<List<models.Post>> fetchPosts(int limit, int offset);

  // Future<List<models.Post>> fetchPosts() async {
  //   return PostService()
  //       .fetchDataForMainScreen(limit: limit, offset: offset)
  //       .then((postList) {
  //     return postList;
  //   });
  // }

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
