import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickingRow extends StatefulWidget {
  final Function onChange;
  const ImagePickingRow({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<ImagePickingRow> createState() => _ImagePickingRowState();
}

class _ImagePickingRowState extends State<ImagePickingRow> {
  List<XFile> images = [];

  _customSetState(VoidCallback fn) {
    setState(fn);
    widget.onChange(images);
  }

  _addImages(List<XFile> _images) {
    _customSetState(() => images.addAll(_images));
  }

  _removeAllImages() {
    _customSetState(() => images.clear());
  }

  _removeImage(int index) {
    _customSetState(() => images.removeAt(index));
  }

  _pickImages() async {
    try {
      final List<XFile>? _images = await ImagePicker().pickMultiImage();
      if (_images == null) return;

      // some magic to limit image pick

      int _length = 5 - images.length - _images.length;
      _length = _length < 0 ? 0 : _length;

      _addImages(_images.take(_length).toList());

      // end
    } on PlatformException catch (e) {
      Exception('Failed to pick image: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (images.length >= 5) {
              _removeAllImages();
            } else {
              _pickImages();
            }
          },
          child: Container(
              width: _size.width / 8,
              height: _size.height / 16,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  border: images.length >= 5
                      ? Border.all(color: Colors.grey)
                      : Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10)),
              child: images.length >= 5
                  ? const Icon(Icons.delete_forever_rounded, color: Colors.grey)
                  : const Icon(Icons.image, color: Colors.green)),
        ),
        images.isNotEmpty
            ? Row(
                children: List.generate(
                  images.length,
                  (index) => InkWell(
                    onTap: () => _removeImage(index),
                    child: Container(
                      width: _size.width / 8,
                      height: _size.height / 16,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 2),
                      child: Image.file(File(images[index].path),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
