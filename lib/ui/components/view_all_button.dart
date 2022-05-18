import 'package:flutter/material.dart';

import '../constants.dart';



class viewAllButton extends StatelessWidget {
  final Function? press;
  const viewAllButton({
    Key? key,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press as void Function()?,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          12,
          6,
          12,
          6,
        ),
        child: Text(
          'View All',
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kBoxShadow),
      ),
    );
  }
}

