import 'package:flutter/material.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/screens/payment/components/payment_container.dart';
import '../../../../widgets/default_appbar.dart';
import '../payment_steps.dart';

class SecondPaymentScreen extends StatelessWidget {
  static String routeName = '/second_payment';

  const SecondPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: DefaultAppBar(title: context.tt('navPayment')),
      body: PaymentContainer(
        size: size,
        paymentSteps: const SecondPaymentStep(),
      ),
    );
  }
}
