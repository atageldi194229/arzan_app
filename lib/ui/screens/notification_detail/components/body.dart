import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart' as models;

import './image_box.dart';
import './complain_button.dart';

class Body extends StatelessWidget {
  final models.NotificationModel notification;
  // final ScrollController controller;
  const Body(
    this.notification, {
    Key? key,
    // required this.controller,
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
    var detailTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: kTextColor,
    );

    return ListView(
      children: [
        Container(
          width: double.infinity,
          margin: cardMargin.copyWith(top: 10),
          padding: ei10,
          decoration: boxDecoration,
          child: ImageBox(images: [notification.image]),
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
                      notification.title,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    notification.createdAt
                        .substring(0, 10)
                        .split('-')
                        .join('.'),
                    style: detailTextStyle,
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
          // child: HtmlTextWidget(
          // html: notification.content,
          // ),
          child: Text(notification.content),
        ),
        const ComplainButton(),
      ],
    );
  }
}
