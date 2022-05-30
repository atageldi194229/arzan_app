import 'package:flutter/material.dart';
import 'package:tm/core/api/models/post_model.dart';
import 'package:tm/ui/constants.dart';

import '../constants.dart';

class ViewIndicator extends StatelessWidget {
  final PostModel post;

  const ViewIndicator(
    this.post, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.remove_red_eye_outlined,
          color: kTextColor,
          size: iconSize,
        ),
        Text(
          post.viewCount.toString(),
          style: detailTextStyle,
        ),
      ],
    );
  }
}
