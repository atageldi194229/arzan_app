import 'package:tm/core/api/services/user_action_service.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/providers/abstract/item_list_provider.dart';

abstract class PostListProvider extends ItemListProvider<PostModel> {
  get posts => items;
  get currentPost => currentItem;

  loadPosts() => load();

  Future<List<PostModel>> fetchPosts(int limit, int offset);

  @override
  fetchItems(int limit, int offset) => fetchPosts(limit, offset);

  void viewPost(PostModel post, {bool listen = true}) {
    post.viewCount++;

    UserActionService()
        .createUserAction(
          UserAction(
            id: post.id,
            count: 1,
            type: UserActionModel.post,
            action: UserActionType.view,
          ),
        )
        .catchError(
          (error) => Future.value(false),
        );

    if (listen) notifyListeners();
  }

  void likePost(PostModel post, {bool listen = true}) {
    bool isLike = post.isLike;
    post.likeCount++;
    post.isLike = true;
    if (listen) notifyListeners();

    UserActionService()
        .createUserAction(
      UserAction(
        id: post.id,
        count: 1,
        type: UserActionModel.post,
        action: UserActionType.like,
      ),
    )
        .catchError((error) {
      post.likeCount--;
      post.isLike = isLike;
      if (listen) notifyListeners();
      return Future.value(false);
    });
  }

  void sharePost(PostModel post, {bool listen = true}) {
    post.shareCount++;
    if (listen) notifyListeners();

    UserActionService()
        .createUserAction(
      UserAction(
        id: post.id,
        count: 1,
        type: UserActionModel.post,
        action: UserActionType.share,
      ),
    )
        .catchError((error) {
      post.shareCount--;
      if (listen) notifyListeners();
      return Future.value(false);
    });
  }

  void favoritePost(PostModel post, {bool listen = true}) {
    bool isFavorite = post.isFavorite;
    // post.favoriteCount++;
    post.isFavorite = !isFavorite;
    if (listen) notifyListeners();

    UserActionService()
        .createUserAction(
      UserAction(
        id: post.id,
        count: isFavorite ? -1 : 1,
        type: UserActionModel.post,
        action: UserActionType.favorite,
      ),
    )
        .catchError((error) {
      // post.likeCount--;
      post.isFavorite = isFavorite;
      if (listen) notifyListeners();
      return Future.value(false);
    });
  }
}
