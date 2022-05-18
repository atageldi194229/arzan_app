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
              boxShadow: kBoxShadow),
          width: getProportionateScreenWidth(150),
          child: Column(children: [
            const DefaultOfficalUserIcon(),
            SizedBox(height: getProportionateScreenHeight(5)),
            const Text(
              'Name surname',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // SizedBox(height: 10),
            Text(
              'lor em ' * 15,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ]),
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
                      child: Image.asset('assets/images/logo_ticket.png'),
                    ),
                    Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(4.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              )
            : Container(),
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
