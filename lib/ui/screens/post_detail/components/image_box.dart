import 'package:flutter/material.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/ui/widgets/image_view.dart';

class ImageBox extends StatelessWidget {
  final PostModel post;
  const ImageBox({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 1.5,
          child: ImageView(images: post.images),
        ),
        Positioned(
          top: -4,
          right: -6,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.bookmark_border_outlined,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
