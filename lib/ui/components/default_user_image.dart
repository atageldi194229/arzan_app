import 'package:flutter/material.dart';

class DefaultUserImage extends StatelessWidget {
  const DefaultUserImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/user_icon.png',
    );
  }
}
