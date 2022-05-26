import 'package:cached_network_image/cached_network_image.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/html_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onTap;

  const PostCard({Key? key, required this.post, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.width / 3.2;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.all(8.0).copyWith(top: 0),
        decoration: kCardDecoration,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: kBorderRadius,
                  // color: kSoftGreen,
                ),
                // child: Stack(
                //   alignment: Alignment.center,
                //   children: [
                //     const Center(
                //       child: CircularProgressIndicator(),
                //     ),
                //     FadeInImage.assetNetwork(
                //       placeholder: imagePlaceholder,
                //       image: post.image,
                //       fit: BoxFit.cover,
                //     ),
                //   ],
                // ),
                child: CachedNetworkImage(
                  imageUrl: post.image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        // colorFilter:
                        // ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Expanded(
                      child: HtmlTextWidget(html: post.content, styles: {
                        "body": Style(
                          fontSize: const FontSize(11),
                          fontWeight: FontWeight.w500,
                          maxLines: 3,
                        )
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
