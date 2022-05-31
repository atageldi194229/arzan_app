import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/core/providers/region_provider.dart';
import 'package:tm/ui/components/official_user.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/keyboard.dart';
import 'package:tm/ui/size_config.dart';
import 'package:tm/ui/widgets/form_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int isActiveColor = 0;

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController descriptionInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    var regionProvidor = context.watch<RegionProvider>();
    var authProvider = context.watch<AuthProvider>();
    var accountProvider = context.watch<AccountProvider>();

    UserModel? user = accountProvider.user;
    var regions = regionProvidor.regions;

    // debugPrint("PROFILE: ${authProvider.isLoggedIn} ${user == null}");

    if (!authProvider.isLoggedIn || user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    usernameInputController.text = user.username;
    descriptionInputController.text = user.about ?? "";
    phoneNumberInputController.text = user.phoneNumber;
    int regionId = user.regions[0].id;

    void _submit() async {
      KeyboardUtil.hideKeyboard(context);
      String username = usernameInputController.text;
      String about = descriptionInputController.text;
      String phoneNumber = phoneNumberInputController.text;
      await AccountService().update(
        about: about,
        image: image,
        phoneNumber: phoneNumber,
        username: username,
        regionIds: regionId,
      );
    }

    Size size = MediaQuery.of(context).size;
    double avatarLogoSize = size.width * 0.3;

    Widget userImageWidget = const DefaultOfficalUserIcon();

    if (image != null) {
      userImageWidget = Container(
        width: avatarLogoSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image.file(
          File(image!.path),
        ),
      );
    } else if (user.image != null) {
      userImageWidget = CachedNetworkImage(
        imageUrl: user.image,
        fit: BoxFit.cover,
        width: avatarLogoSize,
      );
    }

    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double iconSize = constraints.maxWidth * 0.09;
          return Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    userImageWidget,
                    Positioned(
                      bottom: 0,
                      right: iconSize + 0.5,
                      child: Image.asset(
                        'assets/images/official_icon.png',
                        width: iconSize - 7,
                        height: iconSize,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      // child: ImagePickingRow(
                      //   countImage: 2,
                      //   onChange: (values) => images,
                      // )
                      child: InkWell(
                        onTap: () async {
                          XFile? tempImage = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          setState(() => image = tempImage);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 30, 128, 33),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            'assets/images/edit_1.png',
                            width: iconSize / 2.2,
                            height: iconSize / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                    profileSettingUsername(user),
                    const SizedBox(height: 10),
                    const NameContent(text: "About:"),
                    TextFormFielTextarea(
                      text: descriptionInputController.text,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 50),
                    const NameContent(text: "Phone number:"),
                    profileSettingPhoneNumber(user),
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
                        text: regions[index].name,
                        changeColor: isActiveColor == index,
                        press: () {
                          setState(() {
                            isActiveColor = index;
                            regionId = index;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    DefaultButtonGreen(
                      text: "sumbit",
                      press: () {
                        _submit();
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Material profileSettingUsername(user) {
    user = user;
    return Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: usernameInputController,
        onChanged: ((value) {}),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(15),
          ),
          hintText: user.username,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  Material profileSettingPhoneNumber(user) {
    return Material(
      elevation: 5.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: phoneNumberInputController,
        onChanged: ((value) {}),
        decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(15),
          ),
          hintText: 'phone number',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.transparent),
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
      elevation: 10,
      shadowColor: changeColor ? Color.fromARGB(255, 36, 173, 40) : Colors.grey,
      borderRadius: BorderRadius.circular(80),
      child: InkWell(
        onTap: () => press!(),
        child: Container(
            padding: const EdgeInsets.all(10),
            height: iconSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: changeColor ? Colors.green : kTextColor,
                  fontWeight: FontWeight.bold,
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
