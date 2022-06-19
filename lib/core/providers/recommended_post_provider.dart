import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/providers/abstract/post_list_provider.dart';

class RecommendedPostProvider extends PostListProvider {
  int regionId = 0;

  loadPostsByRegion({required int regionId}) {
    this.regionId = regionId;
    return load();
  }

  @override
  Future<List<PostModel>> fetchPosts(int limit, int offset) {
    return PostService().fetchData(
      categoryId: 1,
      regionId: regionId,
      limit: limit,
      offset: offset,
    );
  }
}
