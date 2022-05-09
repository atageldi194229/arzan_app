import 'package:tm/ui/constants.dart';
import 'package:tm/ui/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(12),
          width: SizeConfig.screenWidth * 1.5,
          // height: SizeConfig.screenHeight * 4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'lorem' * 50,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "+993",
                  prefixIcon: const Icon(
                    Icons.phone_callback,
                    color: Colors.green,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(50),
                    vertical: getProportionateScreenWidth(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Container(
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                maxLines: 15,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Your message",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(20),
                    vertical: getProportionateScreenWidth(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding:
                  EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
              child: DefaultButtonGreen(text: "SEND", press: () {}),
            )
          ])),
    );
  }
}
