import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/post_service.dart';

import './abstract/post_list_provider.dart';

class PostSearchProvider extends PostListProvider {
  String? search;

  setSearch(value) async {
    if (search == value) return;

    search = value;
    offset = 0;
    posts.clear();

    await loadPosts();
    notifyListeners();
  }

  @override
  Future<List<PostModel>> fetchPosts(int limit, int offset) {
    return PostService().fetchData(
      limit: limit,
      offset: offset,
      search: search,
    );
  }
}
