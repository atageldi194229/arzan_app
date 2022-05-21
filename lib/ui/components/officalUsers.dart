import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class OfficalUsers extends StatelessWidget {
  final bool iconShow;

  const OfficalUsers({
    Key? key,
    this.iconShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(5),
            // vertical: getProportionateScreenHeight(10)
          ),
          padding: EdgeInsets.all(getProportionateScreenWidth(7)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kBoxShadow,
          ),
          width: getProportionateScreenWidth(150),
          child: Column(
            children: [
              Image.asset(
                'assets/images/user_icon.png',
                width: SizeConfig.screenWidth * 0.5,
                fit: BoxFit.fill,
              ),

              SizedBox(height: getProportionateScreenHeight(5)),
              const Text(
                'Name surname',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kDilegSizedBox + 8),
              // SizedBox(height: 10),
              DefaultButtonGreen(text: 'Follow', press: () {}),
            ],
          ),
        ),
        iconShow == true
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: SizeConfig.screenWidth * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/icon_notification.png',
                        width: SizeConfig.screenWidth * 0.45,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        4.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            : Container(),
        Positioned(
          right: SizeConfig.screenWidth * 0.14,
          bottom: SizeConfig.screenHeight * 0.13,
          child: Image.asset(
            'assets/images/official_icon.png',
            width: getProportionateScreenHeight(30),
          ),
        ),
      ],
    );
  }
}

class DefaultOfficalUserIcon extends StatelessWidget {
  const DefaultOfficalUserIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/logo_ticket.png',
            width: MediaQuery.of(context).size.width / 4,
          ),
        ),
      ),
    );
  }
}
