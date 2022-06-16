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
import 'package:tm/ui/widgets/full_screen_loading.dart';

import 'image_picker.dart';
import 'regions.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

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
              // height: SizeConfig.screenHeight * 0.85,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: kBoxShadow,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
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
                        countImage: 6,
                        onChange: (values) {
                          images = values;
                        },
                        validator: (values) {
                          if (values.isEmpty) {
                            return "Minimum images 1";
                          }

                          return null;
                        },
                      ),
                      const Divider(),
                      SizedBox(height: getProportionateScreenWidth(40)),
                      Material(
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          onChanged: ((value) => title = value),
                          maxLength: 70,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill empty field";
                            }

                            if (value.length <= 5) {
                              return 'Length should be more than 5';
                            }

                            return null;
                          },
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
                          maxLength: 12,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill empty field";
                            }

                            if (!value.startsWith("+993")) {
                              return "Phone number should start with +993";
                            }

                            if (value.length != 12) {
                              return 'Length should be 12';
                            }

                            return null;
                          },
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
                      // TextFormFielTextarea(
                      //   onChanged: (value) => content = value,
                      // ),
                      Material(
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          onChanged: ((value) => content = value),
                          maxLength: 300,
                          maxLines: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Fill empty field";
                            }

                            if (value.length <= 10) {
                              return 'Length should be more than 10';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(20),
                              vertical: getProportionateScreenWidth(15),
                            ),
                            hintText: 'Description...',
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
                      DefaultButtonGreenBack(
                        text: "SEND",
                        onPress: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            _createPost();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isSending,
          child: const FullScreenLoading(),
        ),
      ],
    );
  }
}
