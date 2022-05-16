import 'package:tm/core/api/models/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/html_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  final VoidCallback onTap;
  const NotificationCard(
    this.notification, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.width / 3.2;

    return InkWell(
      onTap: onTap,
      child: _buildContainer(
        height: height,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: kBorderRadius,
                  color: kSoftGreen,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: imagePlaceholder,
                  image: notification.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        notification.title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: HtmlTextWidget(
                        html: notification.content,
                        styles: {
                          "body": Style(
                            fontSize: const FontSize(11),
                            fontWeight: FontWeight.w500,
                            maxLines: 3,
                          ),
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(notification.createdAt.substring(0, 10)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildContainer({
    required double height,
    Widget? child,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(8.0).copyWith(bottom: 0),
      decoration: kCardDecoration,
      child: child,
    );
  }
}
