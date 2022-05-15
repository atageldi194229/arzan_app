import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/api/models/index.dart' as models;
import 'package:tm/core/providers/abstract/post_list_provider.dart';

class HomeScreenProvider extends PostListProvider {
  @override
  Future<List<models.Post>> fetchPosts(int limit, int offset) {
    return PostService().fetchDataForMainScreen(
      limit: limit,
      offset: offset,
    );
  }
}
