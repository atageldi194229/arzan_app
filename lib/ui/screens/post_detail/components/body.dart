import 'package:tm/core/api/models/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/html_text.dart';

import './image_box.dart';
import './complain_button.dart';

class Body extends StatelessWidget {
  final PostModel post;
  final ScrollController controller;
  const Body({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: kBorderRadius,
      // boxShadow: kBoxShadow,
    );

    var ei10 = const EdgeInsets.all(10);
    var cardMargin = const EdgeInsets.all(10).copyWith(top: 0);
    double iconSize = 20;
    var detailTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: kTextColor,
    );

    return NotificationListener<OverscrollNotification>(
      onNotification: (OverscrollNotification value) {
        if (value.overscroll < 0 && controller.offset + value.overscroll <= 0) {
          if (controller.offset != 0) controller.jumpTo(0);
          return true;
        }
        if (controller.offset + value.overscroll >=
            controller.position.maxScrollExtent) {
          if (controller.offset != controller.position.maxScrollExtent) {
            controller.jumpTo(controller.position.maxScrollExtent);
          }
          return true;
        }
        controller.jumpTo(controller.offset + value.overscroll);
        return true;
      },
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            margin: cardMargin.copyWith(top: 10),
            padding: ei10,
            decoration: boxDecoration,
            child: ImageBox(post: post),
          ),
          Container(
            width: double.infinity,
            margin: cardMargin,
            padding: ei10,
            decoration: boxDecoration,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.createdAt
                          .toIso8601String()
                          .substring(0, 10)
                          .split('-')
                          .join('.'),
                      style: detailTextStyle,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: kTextColor,
                          size: iconSize,
                        ),
                        Text(
                          post.viewCount.toString(),
                          style: detailTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: kTextColor,
                          size: iconSize,
                        ),
                        Text(
                          post.shareCount.toString(),
                          style: detailTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: kTextColor,
                          size: iconSize,
                        ),
                        Text(
                          post.likeCount.toString(),
                          style: detailTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: cardMargin,
            padding: ei10,
            decoration: boxDecoration,
            child: HtmlTextWidget(
              html: post.content,
              canLaunch: true,
            ),
          ),
          const ComplainButton(),
        ],
      ),
    );
  }
}
