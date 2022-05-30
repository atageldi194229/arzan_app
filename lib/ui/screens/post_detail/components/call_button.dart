import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class CallButton extends StatelessWidget {
  final String contact;
  const CallButton(
    this.contact, {
    Key? key,
  }) : super(key: key);

  onPressed() {
    launchUrl(Uri(scheme: 'tel', path: contact));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          boxShadow: kBoxShadow,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Tooltip(
          preferBelow: false,
          message: contact,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            onPressed: onPressed,
            child: const Icon(Icons.call),
          ),
        ),
      ),
    );
  }
}
