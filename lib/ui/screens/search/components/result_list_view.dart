import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/providers/post_search_provider.dart';
import 'package:tm/ui/screens/post_detail/post_detail_screen.dart';
import 'package:tm/ui/widgets/post_card.dart';

class ResultListView extends StatefulWidget {
  const ResultListView({Key? key}) : super(key: key);

  @override
  State<ResultListView> createState() => _ResultListViewState();
}

class _ResultListViewState extends State<ResultListView> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
        } else {
          context.read<PostSearchProvider>().loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    PostSearchProvider searchProvider = context.watch<PostSearchProvider>();

    List posts = searchProvider.posts;

    Iterable<Widget> items = posts.map(
      (post) => PostCard(
        post: post,
        onTap: () {
          // open post detail
          int index = posts.indexOf(post);

          context.read<PostSearchProvider>().setCurrentIndex(index);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const PostDetailScreen<PostSearchProvider>();
            }),
          );
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        controller: _controller,
        children: items.toList(),
      ),
    );
  }
}
