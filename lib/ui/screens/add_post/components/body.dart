import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/core/providers/region_provider.dart';

import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/toast.dart';
import 'package:tm/ui/screens/profile/profile_screen.dart';
import 'package:tm/ui/size_config.dart';
import 'package:tm/ui/widgets/button.dart';
import 'package:tm/ui/widgets/form_field.dart';

import 'image_picker.dart';
import 'regions.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<XFile> images = [];
  String title = '';
  String content = '';
  String contact = '';
  List<int> regionIds = [];

  bool isSending = false;

  _showSuccessToast() {
    showToast(context, "Congratulations, you could create your post!!!");

    Navigator.pop(context);
    // Navigator.pushNamed(context, ProfileScreen.routeName);

    var authProvider = context.read<AuthProvider>();
    Navigator.pushNamed(
      context,
      ProfileScreen.routeName,
      arguments: ProfileScreenArguments(
        loadUser: () => AccountService().fetchData(userId: authProvider.userId),
      ),
    );
  }

  _showFailureToast() {
    showToast(context, "Could not create post. Please, try again");
  }

  _createPost() async {
    setState(() {
      isSending = true;
    });

    bool result = await PostService().create(
      images: images,
      title: title,
      content: content,
      regionIds: regionIds,
      contact: contact,
    );

    if (result) {
      _showSuccessToast();
    } else {
      _showFailureToast();

      setState(() {
        isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<RegionModel> regions = context.watch<RegionProvider>().regions;

    List<String> regionNames = regions.map((e) => e.name).toList();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenWidth(2),
              horizontal: getProportionateScreenWidth(2),
            ),
            child: Container(
              width: size.width,
              height: SizeConfig.screenHeight * 0.85,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: kBoxShadow,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Regions(
                        items: regionNames,
                        onChanged: (index) {
                          setState(() {
                            regionIds = [regions[index].id];
                          });
                        },
                      ),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      ImagePickingRow(
                        countImage: 5,
                        onChange: (values) => images = values,
                      ),
                      const Divider(),
                      SizedBox(height: getProportionateScreenWidth(40)),
                      Material(
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          onChanged: ((value) => title = value),
                          maxLines: 4,
                          // keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(20),
                              vertical: getProportionateScreenWidth(15),
                            ),
                            hintText: 'Enter Title...',
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
                      ),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      Material(
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          onChanged: ((value) => contact = value),
                          // keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            contentPadding: const EdgeInsets.all(15),
                            hintText: 'Enter your phone number...',
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
                      ),
                      SizedBox(height: getProportionateScreenWidth(40)),
                      TextFormFielTextarea(
                        onChanged: (value) => content = value,
                      ),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      DefaultButtonGreenBack(
                        text: "SEND",
                        onPress: () => _createPost(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isSending)
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.2),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
