import 'package:flutter/material.dart';
import 'package:tm/core/api/models/post_model.dart';

class FavoriteIndicator extends StatefulWidget {
  final PostModel post;
  const FavoriteIndicator(
    this.post, {
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteIndicator> createState() => _FavoriteIndicatorState();
}

class _FavoriteIndicatorState extends State<FavoriteIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: InkWell(
        onTap: () => widget.post.favoriteIt(notify: () => setState(() {})),
        child: Icon(
          widget.post.isFavorite
              ? Icons.bookmark
              : Icons.bookmark_border_outlined,
          color: const Color(0xff4eb75a),
          size: 30,
        ),
      ),
    );
  }
}
