import 'package:flutter/material.dart';
import 'package:tm/ui/screens/payment/components/payment_container.dart';
import 'payment_steps.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return PaymentContainer(
      size: _size,
      payment_steps: FirstPaymentStep(),
    );
  }
}
