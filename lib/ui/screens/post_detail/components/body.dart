import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;
import 'package:tm/ui/widgets/html_text.dart';

import './image_box.dart';
import './complain_button.dart';

class Body extends StatelessWidget {
  final models.Post post;
  final ScrollController controller;
  const Body({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: kBorderRadius,
      // boxShadow: kBoxShadow,
    );

    var _ei10 = const EdgeInsets.all(10);
    var _cardMargin = const EdgeInsets.all(10).copyWith(top: 0);
    double _iconSize = 20;
    var _detailTextStyle = const TextStyle(
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
            margin: _cardMargin.copyWith(top: 10),
            padding: _ei10,
            decoration: _boxDecoration,
            child: ImageBox(post: post),
          ),
          Container(
            width: double.infinity,
            margin: _cardMargin,
            padding: _ei10,
            decoration: _boxDecoration,
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
                      style: _detailTextStyle,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: kTextColor,
                          size: _iconSize,
                        ),
                        Text(
                          post.viewCount.toString(),
                          style: _detailTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: kTextColor,
                          size: _iconSize,
                        ),
                        Text(
                          post.shareCount.toString(),
                          style: _detailTextStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: kTextColor,
                          size: _iconSize,
                        ),
                        Text(
                          post.likeCount.toString(),
                          style: _detailTextStyle,
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
            margin: _cardMargin,
            padding: _ei10,
            decoration: _boxDecoration,
            child: HtmlTextWidget(
              html: post.content,
            ),
          ),
          const ComplainButton(),
        ],
      ),
    );
  }
}
