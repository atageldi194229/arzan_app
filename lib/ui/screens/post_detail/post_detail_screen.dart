import 'package:flutter/material.dart';
import 'package:tm/core/api/models/post_model.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/abstract/post_list_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:provider/provider.dart';

import 'components/post_detail.dart';

class PostDetailScreen extends StatefulWidget {
  static String routeName = '/post_detail';

  const PostDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  void initState() {
    super.initState();

    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments
          as PostDetailScreenArguments;

      // var post = context.read<T>().currentPost;
      // _viewPost(post);

      _viewPost(args.posts[args.defaultIndex]);
    });
  }

  void _viewPost(PostModel post) {
    post.viewIt(notify: () => setState(() {}));
  }

  // void _loadPosts() {
  // context.read<T>().loadPosts();
  // }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PostDetailScreenArguments;

    // var postListProvider = context.watch<T>();

    List posts = args.posts;
    // int currentIndex = postListProvider.currentIndex;

    final controller = PageController(
      initialPage: args.defaultIndex,
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
            // _loadPosts();
            if (args.loadPosts != null) args.loadPosts!();
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

class PostDetailScreenArguments {
  final List<PostModel> posts;
  final int defaultIndex;
  final Function? loadPosts;

  PostDetailScreenArguments({
    required this.posts,
    this.defaultIndex = 0,
    this.loadPosts,
  });
}
