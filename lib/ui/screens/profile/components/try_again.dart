import 'package:flutter/material.dart';

class TryAgain extends StatelessWidget {
  final void Function()? onPressed;
  const TryAgain({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text("Try again;]"),
      ),
    );
  }
}
