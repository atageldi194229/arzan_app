import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const AppBarButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Center(child: child),
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 9.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kBoxShadow,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
