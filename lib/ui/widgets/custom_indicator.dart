import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      // iOS-specific code
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    // Android-specific code
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
