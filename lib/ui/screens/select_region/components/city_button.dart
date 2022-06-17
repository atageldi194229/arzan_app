import 'package:tm/ui/size_config.dart';
import 'package:flutter/material.dart';

class CityButton extends StatelessWidget {
  const CityButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenHeight(250),
      height: getProportionateScreenHeight(40),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.white,
          backgroundColor: Colors.white,
          // backgroundColor: aPrimaryColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            // fontSize: getProportionateScreenWidth(18),
            color: Colors.grey[900],
          ),
        ),
      ),
    );
  }
}
