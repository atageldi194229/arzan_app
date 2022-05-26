import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/providers/region_status_provider.dart';

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
  List<int> regionIds = [];

  _showSuccessToast() {
    showToast(context, "Congratulations, you could create your post!!!");

    Navigator.pop(context);
    Navigator.pushNamed(context, ProfileScreen.routeName);
  }

  _showFailureToast() {
    showToast(context, "Could not create post. Please, try again");
  }

  _createPost() async {
    bool result = await PostService().create(
      images: images,
      title: title,
      content: content,
      regionIds: regionIds,
    );

    if (result) {
      _showSuccessToast();
    } else {
      _showFailureToast();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<RegionStatusModel> regions =
        context.watch<RegionStatusProvidor>().list;

    List<String> regionNames =
        regions.map((e) => e.name ?? "regionyn name yok").toList();

    return SingleChildScrollView(
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
                      context
                          .read<RegionStatusProvidor>()
                          .setSelectedRegion(regions[index]);
                    },
                  ),
                  SizedBox(height: getProportionateScreenWidth(20)),
                  ImagePickingRow(
                    onChange: (values) => images = values,
                  ),
                  const Divider(),
                  SizedBox(height: getProportionateScreenWidth(40)),
                  TextFormField(
                    onChanged: ((value) => title = value),
                    // keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: 'Title',
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
    );
  }
}
