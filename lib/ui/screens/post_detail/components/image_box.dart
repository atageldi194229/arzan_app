import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/image_view.dart';

class ImageBox extends StatelessWidget {
  final List<String> images;
  final Widget? favoriteIndicator;

  const ImageBox({
    Key? key,
    required this.images,
    this.favoriteIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.width / 1.5,
          child: ImageView(images: images),
        ),
        if (favoriteIndicator != null)
          Positioned(
            top: -4,
            right: -6,
            child: favoriteIndicator!,
          )
      ],
    );
  }
}
