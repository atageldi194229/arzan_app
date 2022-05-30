import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/providers/abstract/item_list_provider.dart';

abstract class PostListProvider extends ItemListProvider<PostModel> {
  List<PostModel> get posts => items;
  PostModel get currentPost => currentItem;

  loadPosts() => load();

  Future<List<PostModel>> fetchPosts(int limit, int offset);

  @override
  fetchItems(int limit, int offset) => fetchPosts(limit, offset);

  viewPost(PostModel post) {
    post.viewIt(notify: () => notifyListeners());
  }

  likePost(PostModel post) {
    post.likeIt(notify: () => notifyListeners());
  }

  sharePost(PostModel post) {
    post.shareIt(notify: () => notifyListeners());
  }

  favoritePost(PostModel post) {
    post.favoriteIt(notify: () => notifyListeners());
  }
}
