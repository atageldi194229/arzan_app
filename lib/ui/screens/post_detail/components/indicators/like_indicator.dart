import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/post_model.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';

import '../constants.dart';

class LikeIndicator extends StatefulWidget {
  final PostModel post;
  const LikeIndicator(this.post, {Key? key}) : super(key: key);

  @override
  State<LikeIndicator> createState() => _LikeIndicatorState();
}

class _LikeIndicatorState extends State<LikeIndicator> {
  @override
  Widget build(BuildContext context) {
    bool isUserLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    var post = widget.post;

    return InkWell(
      onTap: () {
        if (isUserLoggedIn) {
          post.likeIt(notify: () => setState(() {}));
        } else {
          showDialogToLogin(context);
        }
      },
      child: Row(
        children: [
          Icon(
            post.isLike ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: iconSize,
          ),
          Text(
            post.likeCount.toString(),
            style: detailTextStyle.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
