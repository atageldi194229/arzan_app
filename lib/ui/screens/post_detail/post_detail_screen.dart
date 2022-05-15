// import 'package:tm/core/providers/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/providers/abstract/post_list_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class PostDetailScreen<T extends PostListProvider> extends StatefulWidget {
  static String routeName = '/post_detail';

  final Function providerRead;
  final Function providerWatch;

  const PostDetailScreen({
    Key? key,
    required this.providerRead,
    required this.providerWatch,
  }) : super(key: key);

  @override
  State<PostDetailScreen<T>> createState() => _PostDetailScreenState<T>();
}

class _PostDetailScreenState<T extends PostListProvider>
    extends State<PostDetailScreen<T>> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      var post = context.read<T>().currentPost;
      _viewPost(post);
    });
  }

  void _viewPost(post) async {
    context.read<T>().viewPost(post);
  }

  void _loadPosts() {
    context.read<T>().loadPosts();
  }

  bool _firstTime = false;
  firstTimeCall(PageController controller) {
    if (_firstTime) return;
    _firstTime = true;

    controller.addListener(() {
      if (controller.page != null) {
        double next = controller.page!.ceilToDouble() - controller.page!;
        double prev = controller.page! - controller.page!.floorToDouble();

        const double startScrollPage = 0.2;
        const Duration duration = Duration(milliseconds: 300);
        const Curve curve = Curves.easeInOut;

        if (startScrollPage > prev) {
          controller.nextPage(
            duration: duration,
            curve: curve,
          );
        }

        if (startScrollPage > next) {
          controller.previousPage(
            duration: duration,
            curve: curve,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var postListProvider = context.watch<T>();

    List posts = postListProvider.posts;
    int currentIndex = postListProvider.currentIndex;

    final _controller = PageController(
      initialPage: currentIndex,
    );

    firstTimeCall(_controller);

    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: const DefaultAppBar(title: 'Post Detail'),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: _controller,
        onPageChanged: (index) {
          _viewPost(posts[index]);
          if (posts.length - 5 < index) {
            _loadPosts();
          }
        },
        children: List.generate(
          posts.length,
          (index) => Body(
            post: posts[index],
            controller: _controller,
          ),
        ),
      ),
    );
  }

  alertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('data', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('data' * 10),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
