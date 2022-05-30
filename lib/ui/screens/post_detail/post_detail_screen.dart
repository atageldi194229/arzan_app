import 'package:flutter/material.dart';
import 'package:tm/core/api/models/post_model.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/abstract/post_list_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:provider/provider.dart';

import 'components/post_detail.dart';

class PostDetailScreen<T extends PostListProvider> extends StatefulWidget {
  static String routeName = '/post_detail';

  const PostDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PostDetailScreen<T>> createState() => _PostDetailScreenState<T>();
}

class _PostDetailScreenState<T extends PostListProvider>
    extends State<PostDetailScreen<T>> {
  @override
  void initState() {
    super.initState();

    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      var post = context.read<T>().currentPost;
      _viewPost(post);
    });
  }

  void _viewPost(PostModel post) {
    post.viewIt(notify: () => setState(() {}));
  }

  void _loadPosts() {
    context.read<T>().loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    var postListProvider = context.watch<T>();

    List posts = postListProvider.posts;
    int currentIndex = postListProvider.currentIndex;

    final controller = PageController(
      initialPage: currentIndex,
    );

    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: DefaultAppBar(title: context.tt('post_detail')),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged: (index) {
          _viewPost(posts[index]);
          if (posts.length - 5 < index) {
            _loadPosts();
          }
        },
        children: List.generate(
          posts.length,
          (index) => PostDetail(posts[index]),
        ),
      ),
    );
  }
}
