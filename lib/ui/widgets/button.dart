import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultButtonGreenBack extends StatelessWidget {
  final String text;
  final Function? onPress;
  const DefaultButtonGreenBack({Key? key, required this.text, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress!(),
      child: Container(
        padding: const EdgeInsets.all(10),
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kSoftGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
