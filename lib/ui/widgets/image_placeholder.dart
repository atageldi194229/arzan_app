import 'package:flutter/material.dart';

import '../constants.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(Icons.image_outlined),
        ],
      ),
    );
  }
}
