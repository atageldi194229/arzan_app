import 'package:tm/core/api/models/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/html_text.dart';

import 'image_box.dart';
import 'complain_button.dart';
import 'call_button.dart';
import 'constants.dart';
import 'indicators/favorite_indicator.dart';
import 'indicators/like_indicator.dart';
import 'indicators/share_indicator.dart';
import 'indicators/view_indicator.dart';

class Body extends StatelessWidget {
  final PostModel post;
  final Function? onFavorite;

  const Body({
    Key? key,
    required this.post,
    this.onFavorite,
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

    return ListView(
      children: [
        Container(
          width: double.infinity,
          margin: cardMargin.copyWith(top: 10),
          padding: ei10,
          decoration: boxDecoration,
          child: ImageBox(
            images: post.images,
            favoriteIndicator: FavoriteIndicator(post),
          ),
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
                  ViewIndicator(post),
                  ShareIndicator(post),
                  LikeIndicator(post),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            post.contacts.length,
            (index) => CallButton(post.contacts[index]),
          ),
        ),
        const ComplainButton(),
      ],
    );
  }
}
