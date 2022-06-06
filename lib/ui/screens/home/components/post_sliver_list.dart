import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/providers/home_screen_provider.dart';
import 'package:tm/ui/screens/post_detail/post_detail_screen.dart';
import 'package:tm/ui/widgets/custom_indicator.dart';
import 'package:tm/ui/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostSliverList extends StatefulWidget {
  const PostSliverList({Key? key}) : super(key: key);

  @override
  State<PostSliverList> createState() => _PostSliverListState();
}

class _PostSliverListState extends State<PostSliverList> {
  @override
  void initState() {
    super.initState();
    context.read<HomeScreenProvider>().loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = context.watch<HomeScreenProvider>().posts;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == posts.length) {
            return const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 80),
              child: CustomIndicator(),
            );
          }
          return PostCard(
            post: posts[index],
            onTap: () {
              context.read<HomeScreenProvider>().setCurrentIndex(index);
              Navigator.pushNamed(
                context,
                PostDetailScreen.routeName,
                arguments: PostDetailScreenArguments(
                  posts: posts,
                  defaultIndex: index,
                  loadPosts: context.read<HomeScreenProvider>().loadPosts,
                ),
              );
            },
          );
        },
        childCount: posts.length + 1,
      ),
    );
  }
}
