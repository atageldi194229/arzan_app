import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/image_view.dart';

class ImageBox extends StatelessWidget {
  final List<String> images;
  const ImageBox({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SizedBox(
      width: _size.width,
      height: _size.width / 1.5,
      // color: kSoftGreen,
      // child: FadeInImage.assetNetwork(
      //   placeholder: imagePlaceholder,
      //   image: post.image,
      //   fit: BoxFit.contain,
      // ),

      child: ImageView(images: images),
    );
  }
}
