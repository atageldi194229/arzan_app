import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';

class ImageView extends StatelessWidget {
  final List<String> images;

  const ImageView({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = images.map(_buildImageWidget).toList();

    return PageView(
      // scrollDirection: Axis.vertical,
      children: _list,
    );
  }

  Widget _buildImageWidget(String image) {
    return FadeInImage.assetNetwork(
      placeholder: imagePlaceholder,
      image: image,
      fit: BoxFit.contain,
    );
  }
}
