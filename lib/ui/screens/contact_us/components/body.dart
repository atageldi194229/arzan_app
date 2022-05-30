import 'package:tm/ui/constants.dart';
import 'package:tm/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/widgets/form_field.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(12),
          width: SizeConfig.screenWidth * 1.5,
          // height: SizeConfig.screenHeight * 4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Biziň bilen habarlaşmak üçin şu aşakdaky telefon belgä aýlamagyňyzy haýyş edýäris.'
                '\n +99364103444',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(10),
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
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Container(
              width: SizeConfig.screenWidth * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormFielTextarea(
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  EdgeInsets.only(bottom: getProportionateScreenHeight(20)),
              child: DefaultButtonGreen(text: "SEND", press: () {}),
            )
          ])),
    );
  }
}
