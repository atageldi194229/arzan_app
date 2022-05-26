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
    post.likeCount++;

    UserActionService()
        .createUserAction(
          UserAction(
            id: post.id,
            count: 1,
            type: UserActionModel.post,
            action: UserActionType.like,
          ),
        )
        .catchError(
          (error) => Future.value(false),
        );

    if (listen) notifyListeners();
  }

  void sharePost(PostModel post, {bool listen = true}) {
    post.shareCount++;

    UserActionService()
        .createUserAction(
          UserAction(
            id: post.id,
            count: 1,
            type: UserActionModel.post,
            action: UserActionType.share,
          ),
        )
        .catchError(
          (error) => Future.value(false),
        );

    if (listen) notifyListeners();
  }
}
