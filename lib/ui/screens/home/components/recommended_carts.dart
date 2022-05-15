import 'dart:async';

import 'package:tm/core/api/models/index.dart' as models;
import 'package:tm/core/providers/recommended_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/screens/post_detail/post_detail_screen.dart';
import './recommended_card.dart';

class RecommendedCarts extends StatefulWidget {
  const RecommendedCarts({Key? key}) : super(key: key);

  @override
  State<RecommendedCarts> createState() => _RecommendedCartsState();
}

class _RecommendedCartsState extends State<RecommendedCarts> {
  final _controller = ScrollController();
  Timer? timer;

  _onLayoutDone(_) {
    Size _size = MediaQuery.of(context).size;

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (timer.tick == 1) return;

      double offset = _controller.offset;
      double maxOffset = _controller.position.maxScrollExtent;

      if (maxOffset - offset == 0) {
        offset = 0;
      } else {
        offset += _size.width;
      }

      _controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease,
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<models.Post> posts = context.watch<RecommendedPostProvider>().posts;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
      child: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            posts.length,
            (index) => RecommendedCard(
              post: posts[index],
              onTap: () {
                context.read<RecommendedPostProvider>().setCurrentIndex(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PostDetailScreen<RecommendedPostProvider>(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
