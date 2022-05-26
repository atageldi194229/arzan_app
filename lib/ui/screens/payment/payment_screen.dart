import "package:flutter/material.dart";
import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/screens/payment/components/body.dart';
import 'package:tm/ui/widgets/default_appbar.dart';

class PaymentScreen extends StatelessWidget {
  static String routeName = '/payment';

  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: context.tt('navPayment')),
      body: const Body(),
    );
  }
}
