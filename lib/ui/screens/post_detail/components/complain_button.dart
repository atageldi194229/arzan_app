import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class ComplainButton extends StatelessWidget {
  const ComplainButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        highlightColor: Colors.transparent,
        // onTap: () => alertDialog(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: kBorderRadius,
            boxShadow: kBoxShadow,
          ),
          child: const Text(
            'Complain',
            style: TextStyle(
              color: Colors.red,
              letterSpacing: 0.7,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
