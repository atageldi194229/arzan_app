import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/api/models/index.dart' as models;
import 'package:tm/core/providers/abstract/post_list_provider.dart';

class RecommendedPostProvider extends PostListProvider {
  @override
  Future<List<models.Post>> fetchPosts(int limit, int offset) {
    return PostService().fetchData();
  }
}


// class RecommendedPostProvider with ChangeNotifier {
//   late List<models.Post> _posts = <models.Post>[];

//   get posts => _posts;

//   set posts(value) {
//     _posts = value;
//     notifyListeners();
//   }

//   getRecommendedPosts() {
//     PostService()
//         .fetchData()
//         .then((value) => posts = value)
//         .catchError((err) {});
//   }
// }
