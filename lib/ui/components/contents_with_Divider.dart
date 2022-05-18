import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';



class NameContentHome extends StatelessWidget {
  final String text;
  final int? count;
  const NameContentHome({Key? key, required this.text, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              Text(
                text == null ? '' : text, // **************************
                style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Spacer(),
              Text(count == null ? '' : count.toString())
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: SizedBox(
              width: double.infinity,
              height: getProportionateScreenHeight(3),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ))
      ],
    );
  }
}