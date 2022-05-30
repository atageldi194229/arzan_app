import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tm/core/api/models/post_model.dart';

import '../constants.dart';

class ShareIndicator extends StatefulWidget {
  final PostModel post;
  const ShareIndicator(this.post, {Key? key}) : super(key: key);

  @override
  State<ShareIndicator> createState() => _ShareIndicatorState();
}

class _ShareIndicatorState extends State<ShareIndicator> {
  @override
  Widget build(BuildContext context) {
    var post = widget.post;
    return InkWell(
      onTap: (() {
        post.shareIt(notify: () => setState(() {}));

        Share.share(
          Uri(
            scheme: 'http',
            host: 'arzan.info',
            port: 5152,
            path: 'posts/${post.id}',
          ).toString(),
          // subject: post.title,
        );
      }),
      child: Row(
        children: [
          const Icon(
            Icons.share_outlined,
            size: iconSize,
            color: Colors.orange,
          ),
          Text(
            post.shareCount.toString(),
            style: detailTextStyle.copyWith(
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
