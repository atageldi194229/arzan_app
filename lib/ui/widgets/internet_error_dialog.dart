import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class InternetErrorDialog extends AlertDialog {
  const InternetErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: const Text(
        'No internet connection',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.signal_wifi_off_rounded,
              size: 60, color: kSoftGreen),
          const Text(
            'Please check your Internet connection!',
            textAlign: TextAlign.center,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
                color: kSoftGreen, borderRadius: BorderRadius.circular(25)),
            child: Text(
              'retry'.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
