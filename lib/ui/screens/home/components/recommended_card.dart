import 'package:cached_network_image/cached_network_image.dart';
import 'package:tm/core/api/models/index.dart' as models;
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class RecommendedCard extends StatelessWidget {
  final models.Post post;
  final Function onTap;
  const RecommendedCard({
    Key? key,
    required this.post,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double cardWidth = size.width / 3.8;
    double cardHeight = cardWidth * 1.3;

    return InkWell(
      onTap: () =>
          onTap(), //=> MyRouter().route(context, PostDetailPage(model: model!)),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(4),
        decoration: kCardDecoration,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: kBorderRadius,
                // color: kSoftGreen,
              ),
              // child: Stack(
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
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  // decoration: mbd.rcmCardLabel(),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                  ),

                  child: Text(
                    post.title,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
