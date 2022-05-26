import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({
    Key? key,
    required Size size,
    required this.payment_steps,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final Widget payment_steps;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 148, 33),
                    boxShadow: kBoxShadow,
                  ),
                  width: _size.width,
                  height: _size.height / 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/images/logo_app.png',
                          color: Colors.white,
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _size.width,
            height: _size.height * 1.2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(100),
                    horizontal: getProportionateScreenHeight(20),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: _size.width,
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.12),
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 10,
                          left: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: kBoxShadow,
                        ),
                        child: payment_steps,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: SizeConfig.screenHeight * 0.04,
                            left: SizeConfig.screenHeight * 0.17,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/payment.png',
                                  width: SizeConfig.screenWidth * 0.3,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
