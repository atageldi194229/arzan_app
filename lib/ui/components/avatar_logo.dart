import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';

class AvatarLogo extends StatelessWidget {
  final String? image;
  const AvatarLogo(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSoftGreen,
        shape: BoxShape.circle,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          Widget placeholder = Icon(
            Icons.person_outline_outlined,
            size: constraints.biggest.height,
            color: Colors.white,
          );

          if (image == null || image!.isEmpty) {
            return placeholder;
          }

          return CircleAvatar(
            maxRadius: constraints.biggest.height / 2,
            backgroundImage: CachedNetworkImageProvider(image!),
          );
        },
      ),
    );
  }
}
