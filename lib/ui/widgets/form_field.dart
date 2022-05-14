import 'package:flutter/material.dart';

import '../size_config.dart';

class TextFormFielTextarea extends StatelessWidget {
  final Function onChanged;

  const TextFormFielTextarea({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.81,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => onChanged(value),
        maxLines: 14,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Content",
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
            vertical: getProportionateScreenWidth(15),
          ),
        ),
      ),
    );
  }
}
