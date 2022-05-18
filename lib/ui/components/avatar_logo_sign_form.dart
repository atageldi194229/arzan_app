import 'package:flutter/material.dart';

import '../constants.dart';

class AvatarLogo extends StatelessWidget {
  const AvatarLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: kSoftGreen,
        shape: BoxShape.circle,
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Icon(
            Icons.account_circle_outlined,
            color: Colors.white,
            size: constraint.biggest.height,
          );
        },
      ),
    );
  }
}
