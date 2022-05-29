import 'package:flutter/material.dart';
import 'package:tm/ui/components/official_user.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/size_config.dart';
import 'package:tm/ui/widgets/form_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    bool colorChange = false;
    List regions = ["Balkan", "Ahal", "Lebap", "Dasoguz", "Asgabat", "Mary"];
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double iconSize = constraints.maxWidth * 0.09;
          return Column(
            children: [
              Container(
                child: Center(
                  child: Stack(
                    children: [
                      const DefaultOfficalUserIcon(),
                      Positioned(
                        bottom: 0,
                        right: iconSize + 0.5,
                        child: Image.asset(
                          'assets/images/official_icon.png',
                          width: iconSize,
                          height: iconSize,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 30, 128, 33),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            'assets/images/edit_1.png',
                            width: iconSize / 2,
                            height: iconSize / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text('Add banner: '),
              Material(
                elevation: 6,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: SizeConfig.screenWidth * 0.5,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.image,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenHeight(10),
                ),
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    const NameContent(text: "Username: "),
                    profileSettingUsername(),
                    const SizedBox(height: 10),
                    const NameContent(text: "About:"),
                    TextFormFielTextarea(
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 50),
                    const NameContent(text: "Phone number:"),
                    profileSettingPhoneNumber(),
                    const SizedBox(height: 50),
                    const NameContent(text: "Regions:"),
                    GridView.builder(
                      itemCount: regions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemBuilder: (context, index) => RegionsProfileSetting(
                        iconSize: iconSize,
                        text: regions[index],
                        changeColor: colorChange,
                        press: () {
                          setState(() {
                            colorChange = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    DefaultButtonGreen(
                      text: "sumbit",
                      press: () {},
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Material profileSettingUsername() {
    return Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        onChanged: ((value) {}),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(15),
          ),
          hintText: 'username',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Material profileSettingPhoneNumber() {
    return Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        onChanged: ((value) {}),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(15),
          ),
          hintText: 'username',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}

class RegionsProfileSetting extends StatelessWidget {
  final String text;
  final bool changeColor;
  final GestureTapCallback? press;

  const RegionsProfileSetting({
    Key? key,
    required this.iconSize,
    required this.text,
    this.changeColor = false,
    this.press,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: changeColor ? Colors.green : Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => press!(),
        child: Container(
            padding: EdgeInsets.all(10),
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: kTextColor,
                ),
              ),
            )),
      ),
    );
  }
}

class NameContent extends StatelessWidget {
  final String text;
  const NameContent({Key? key, required this.text})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: getProportionateScreenHeight(12)),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: const TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
