import 'package:share_plus/share_plus.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/html_text.dart';
import 'package:url_launcher/url_launcher.dart';

import './image_box.dart';
import './complain_button.dart';

class Body extends StatelessWidget {
  final PostModel post;
  final ScrollController controller;
  final Function? onLike;
  final Function? onShare;
  final Function? onFavorite;

  const Body({
    Key? key,
    required this.post,
    required this.controller,
    this.onLike,
    this.onShare,
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
            child: ImageBox(
              post: post,
              isFavorite: post.isFavorite,
              onFavorite: () {
                if (onFavorite != null) onFavorite!(post);
              },
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
                    InkWell(
                      onTap: (() {
                        if (onShare != null) onShare!(post);

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
                          Icon(
                            Icons.share_outlined,
                            // color: kTextColor,
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
                    ),
                    InkWell(
                      onTap: () {
                        if (onLike != null) onLike!(post);
                      },
                      child: Row(
                        children: [
                          Icon(
                            post.isLike
                                ? Icons.favorite
                                : Icons.favorite_border,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              post.contacts.length,
              (index) => CallButton(post.contacts[index]),
            ),
          ),
          const ComplainButton(),
        ],
      ),
    );
  }
}

class CallButton extends StatelessWidget {
  final String contact;
  const CallButton(
    this.contact, {
    Key? key,
  }) : super(key: key);

  onPressed() {
    launchUrl(Uri(scheme: 'tel', path: contact));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          boxShadow: kBoxShadow,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Tooltip(
          preferBelow: false,
          message: contact,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            onPressed: onPressed,
            child: const Icon(Icons.call),
          ),
        ),
      ),
    );
  }
}
