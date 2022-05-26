import 'package:flutter/material.dart';
import 'package:tm/ui/screens/payment/components/button.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/fourth_payment_step.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/success_screen.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/third_payment_step.dart';
import 'package:tm/ui/screens/payment/components/radio_list.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/second_payment_step.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'linear_title_text.dart';

// first step______________________________________________________
class FirstPaymentStep extends StatefulWidget {
  const FirstPaymentStep({Key? key}) : super(key: key);

  @override
  State<FirstPaymentStep> createState() => _FirstPaymentStepState();
}

bool _value = false;
int? val = -1;

class _FirstPaymentStepState extends State<FirstPaymentStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
          // height: getProportionateScreenHeight(180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PaymentTitle(
                title: "1 step",
                text: 'Choose a Service',
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              SizedBox(height: kDilegSizedBox),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.3),
                child: NextBtn(
                  press: () {
                    Navigator.pushNamed(context, SecondPaymentScreen.routeName);
                  },
                  text: 'next',
                  icon: Icons.arrow_right_alt,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// second step______________________________________________________

class SecondPaymentStep extends StatefulWidget {
  const SecondPaymentStep({Key? key}) : super(key: key);

  @override
  State<SecondPaymentStep> createState() => _SecondPaymentStepState();
}

class _SecondPaymentStepState extends State<SecondPaymentStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
          // height: getProportionateScreenHeight(180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PaymentTitle(
                title: "2 step",
                text: 'Choose a Region',
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              SizedBox(height: kDilegSizedBox),
              NextPreBtn(
                submit_btn: "next",
                press_next: () {
                  Navigator.pushNamed(context, ThirdPaymentScreen.routeName);
                },
                press_prev: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

//third step

class ThirdPaymentStep extends StatefulWidget {
  const ThirdPaymentStep({Key? key}) : super(key: key);

  @override
  State<ThirdPaymentStep> createState() => _ThirdPaymentStepState();
}

class _ThirdPaymentStepState extends State<ThirdPaymentStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
          // height: getProportionateScreenHeight(180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PaymentTitle(
                title: "3 step",
                text: 'Choose a Duration',
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                price_status: true,
                price: 123,
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                price_status: true,
                price: 123,
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              RadioList(
                price_status: true,
                price: 123,
                press: (value) {
                  setState(() {
                    val = value as int?;
                    _value = true;
                  });
                },
                groupVal: 2,
                text: 'Asgabat',
                value: 1,
                selectedValue: _value,
              ),
              const SizedBox(height: kDilegSizedBox),
              NextPreBtn(
                submit_btn: "next",
                press_prev: () {
                  Navigator.pop(context);
                },
                press_next: () {
                  Navigator.pushNamed(context, FourthPaymentScreen.routeName);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

//fouth step

class FourthStepPayment extends StatefulWidget {
  const FourthStepPayment({Key? key}) : super(key: key);

  @override
  State<FourthStepPayment> createState() => _FourthStepPaymentState();
}

class _FourthStepPaymentState extends State<FourthStepPayment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
          // height: getProportionateScreenHeight(180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PaymentTitle(
                title: "4 step",
                text: 'Confirmation',
              ),
              const SizedBox(height: kDilegSizedBox + 10),
              UserDetailPayment(user_name: "Sergo", title: "name"),
              UserDetailPayment(user_name: "Sergo", title: "name"),
              UserDetailPayment(user_name: "Sergo", title: "name"),
              UserDetailPayment(user_name: "Sergo", title: "name"),
              const SizedBox(height: kDilegSizedBox),
              NextPreBtn(
                icon_status: false,
                submit_btn: "submit",
                press_prev: () {
                  Navigator.pop(context);
                },
                press_next: () {
                  Navigator.pushNamed(context, SuccessPaymentScreen.routeName);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

// success payment

class SuccessPaymentStep extends StatefulWidget {
  const SuccessPaymentStep({Key? key}) : super(key: key);

  @override
  State<SuccessPaymentStep> createState() => _SuccessPaymentStepState();
}

class _SuccessPaymentStepState extends State<SuccessPaymentStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
          // height: getProportionateScreenHeight(180),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Request successfully send!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: kDilegSizedBox + 10,
              ),
              const Text(
                'Contact with us',
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: kDilegSizedBox + 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.message_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(width: kDilegSizedBox),
                  Text(
                    'info@arzan.info',
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.phone_android_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(width: kDilegSizedBox),
                  Text(
                    '+993-64-10-34-44',
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
