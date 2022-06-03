import 'package:flutter/material.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/payment/components/button.dart';
import 'package:tm/ui/screens/payment/components/linear_title_text.dart';
import 'package:tm/ui/size_config.dart';

//first payment step

class FirstPaymentStep extends StatefulWidget {
  const FirstPaymentStep({Key? key}) : super(key: key);

  @override
  State<FirstPaymentStep> createState() => _FirstPaymentStepState();
}

class _FirstPaymentStepState extends State<FirstPaymentStep> {
  bool _value = false;
  int? val = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const PaymentTitle(
            title: "1 step",
            text: "Choose a service",
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RadioListTile(
                  value: 1,
                  groupValue: val,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      val = value as int?;
                      _value = true;
                    });
                  },
                  title: const Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  selected: _value,
                ),
                RadioListTile(
                  value: 2,
                  activeColor: Colors.green,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int?;
                      _value = true;
                    });
                  },
                  title: Text(context.tt('selected Post'),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  selected: _value,
                ),
                RadioListTile(
                  value: 3,
                  activeColor: Colors.green,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int?;
                      _value = true;
                    });
                  },
                  title: Text(context.tt('unrealiable_of_informtion'),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  selected: _value,
                ),
                RadioListTile(
                  value: 4,
                  activeColor: Colors.green,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int?;
                      _value = true;
                    });
                  },
                  title: Text(context.tt('other'),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  selected: _value,
                ),
                RadioListTile(
                  value: 5,
                  activeColor: Colors.green,
                  groupValue: val,
                  onChanged: (value) {
                    setState(() {
                      val = value as int?;
                      _value = true;
                    });
                  },
                  title: Text(context.tt('other'),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700)),
                  selected: _value,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: NextBtn(
                    text: "next",
                    icon: Icons.arrow_right,
                    press: () {},
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//second payment step

class SecondPaymentStep extends StatefulWidget {
  const SecondPaymentStep({Key? key}) : super(key: key);

  @override
  State<SecondPaymentStep> createState() => _SecondPaymentStepState();
}

class _SecondPaymentStepState extends State<SecondPaymentStep> {
  bool _value = false;
  int? val = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const PaymentTitle(
            title: "2 step",
            text: "Choose a Regions",
          ),
          const SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(
                bottom: getProportionateScreenHeight(kDilegSizedBox + 5)),
            height: getProportionateScreenHeight(300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RadioListTile(
                    value: 1,
                    groupValue: val,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                        _value = true;
                      });
                    },
                    title: Text(
                      context.tt('Ashgabat'),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    selected: _value,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 2,
                    activeColor: Colors.green,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                        _value = true;
                      });
                    },
                    title: Text(context.tt('Ahal'),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                    selected: _value,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 3,
                    activeColor: Colors.green,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                        _value = true;
                      });
                    },
                    title: Text(context.tt('Mary'),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                    selected: _value,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 4,
                    activeColor: Colors.green,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                        _value = true;
                      });
                    },
                    title: Text(context.tt('Lebap'),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                    selected: _value,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 5,
                    activeColor: Colors.green,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                        _value = true;
                      });
                    },
                    title: Text(context.tt('Dasoguz'),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                    selected: _value,
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 6,
                    activeColor: Colors.green,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                        _value = true;
                      });
                    },
                    title: Text(context.tt('Balkan'),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700)),
                    selected: _value,
                  ),
                ),

                // RadioListTile(
                //   value: 1,
                //   groupValue: val,
                //   activeColor: Colors.green,
                //   onChanged: (value) {
                //     setState(() {
                //       val = value as int?;
                //       _value = true;
                //     });
                //   },
                //   title: Text(
                //     context.tt('All'),
                //     style: const TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   selected: _value,
                // ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PrevNextBtns(
              pressNext: () {},
              pressBack: () {
                print('object');
              }),
        ],
      ),
    );
  }
}

//third payment step

class ThirdPaymentStep extends StatefulWidget {
  const ThirdPaymentStep({Key? key}) : super(key: key);

  @override
  State<ThirdPaymentStep> createState() => _ThirdPaymentStepState();
}

class _ThirdPaymentStepState extends State<ThirdPaymentStep> {
  bool _value = false;
  int? val = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const PaymentTitle(
            title: "3 step",
            text: "Choose duration",
          ),
          const SizedBox(
            height: 20,
          ),
          RadioListTile(
            value: 1,
            activeColor: Colors.green,
            groupValue: val,
            onChanged: (value) {
              setState(() {
                val = value as int?;
                _value = true;
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tt("1 week"),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const Text(
                  "100 TMT",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
              ],
            ),
            selected: _value,
          ),
          RadioListTile(
            value: 1,
            activeColor: Colors.green,
            groupValue: val,
            onChanged: (value) {
              setState(() {
                val = value as int?;
                _value = true;
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tt("1 month"),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const Text(
                  "300 TMT",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
              ],
            ),
            selected: _value,
          ),
          RadioListTile(
            value: 3,
            activeColor: Colors.green,
            groupValue: val,
            onChanged: (value) {
              setState(() {
                val = value as int?;
                _value = true;
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tt("1 year"),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                const Text(
                  "500 TMT",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
              ],
            ),
            selected: _value,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          PrevNextBtns(pressNext: () {}, pressBack: () {})
        ],
      ),
    );
  }
}

//fourth payment step

class FourthPaymentStep extends StatefulWidget {
  const FourthPaymentStep({Key? key}) : super(key: key);

  @override
  State<FourthPaymentStep> createState() => _FourthPaymentStepState();
}

class _FourthPaymentStepState extends State<FourthPaymentStep> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const PaymentTitle(
            title: "4 step",
            text: "Confirmation",
          ),
          const SizedBox(
            height: 20,
          ),
          UserContent(),
          UserContent(),
          UserContent(),
          UserContent(),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_left,
                        color: Colors.white,
                      ),
                      Text(
                        'back'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'submit'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class UserContent extends StatelessWidget {
  const UserContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Name: ',
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text('serg'),
            ],
          ),
          SizedBox(height: 10),
          const Divider(
            thickness: 2,
            color: Colors.green,
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
