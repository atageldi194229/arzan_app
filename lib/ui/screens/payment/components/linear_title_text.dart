import 'package:flutter/material.dart';

import '../../../constants.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    required this.gradient,
    this.style,
  });
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class PaymentTitle extends StatelessWidget {
  final String title;
  final String? text;
  const PaymentTitle({
    Key? key,
    required this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          GradientText(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            gradient: const LinearGradient(
              colors: [
                Colors.teal,
                Color.fromARGB(255, 6, 51, 8),
              ],
            ),
          ),
          Text(
            text!,
            style: const TextStyle(
                color: Color.fromARGB(255, 34, 33, 33),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class UserDetailPayment extends StatelessWidget {
  final String title;
  final String user_name;
  const UserDetailPayment({
    Key? key,
    required this.title,
    required this.user_name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            Text(
              user_name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            )
          ],
        ),
        const Divider(
          color: Colors.green,
          thickness: 2,
        ),
        const SizedBox(
          height: kDilegSizedBox + 10,
        ),
      ],
    );
  }
}
