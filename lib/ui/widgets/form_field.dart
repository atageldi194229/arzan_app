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
    return Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: SizeConfig.screenWidth * 0.90,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: (value) => onChanged(value),
          maxLines: 12,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "Description...",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenWidth(15),
            ),
          ),
        ),
      ),
    );
  }
}
