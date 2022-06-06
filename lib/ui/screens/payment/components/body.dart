import 'package:flutter/material.dart';
import 'package:tm/ui/screens/payment/components/payment_container.dart';
import 'package:tm/ui/screens/payment/payment_steps.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    Size size = MediaQuery.of(context).size;
    return PaymentContainer(
      size: size,
      paymentSteps: PageView(
        controller: controller,
        children: const <Widget>[
          FirstPaymentStep(),
          SecondPaymentStep(),
          ThirdPaymentStep(),
          FourthPaymentStep()
        ],
      ),
    );
  }
}
