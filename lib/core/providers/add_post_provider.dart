import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostProvider with ChangeNotifier {
  List<XFile> images = [];
  String title = '';
  String content = '';
  List<int> regionIds = [];

  // createPost() {
  //   return PostService().create(
  //     images: images,
  //     title: title,
  //     content: content,
  //     regionIds: regionIds,
  //   );
  // }
}
