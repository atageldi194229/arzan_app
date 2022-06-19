import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickingRow extends StatefulWidget {
  final Function onChange;
  final int countImage;
  final String? Function(List<XFile> values)? validator;
  // final StreamController? validatorController;
  const ImagePickingRow({
    Key? key,
    required this.onChange,
    required this.countImage,
    this.validator,
    // this.validatorController,
  }) : super(key: key);

  @override
  State<ImagePickingRow> createState() => _ImagePickingRowState();
}

class _ImagePickingRowState extends State<ImagePickingRow> {
  List<XFile> images = [];
  String? errorText;

  @override
  void initState() {
    super.initState();

    // widget.validatorController!.stream.listen((_) => _validate());
  }

  _validate() {
    if (widget.validator != null) {
      setState(() {
        errorText = widget.validator!(images);
      });
    }
  }

  _customSetState(VoidCallback fn) {
    setState(fn);
    widget.onChange(images);

    _validate();
  }

  _addImages(List<XFile> images) {
    _customSetState(() => this.images.addAll(images));
  }

  _removeAllImages() {
    _customSetState(() => images.clear());
  }

  _removeImage(int index) {
    _customSetState(() => images.removeAt(index));
  }

  _pickImages() async {
    try {
      final List<XFile>? images = await ImagePicker().pickMultiImage();
      if (images == null) return;

      // some magic to limit image pick

      int length = widget.countImage - this.images.length - images.length;
      length = length < 0 ? 0 : length;

      _addImages(images.take(length).toList());

      // end
    } on PlatformException catch (e) {
      Exception('Failed to pick image: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (images.length >= widget.countImage) {
                  _removeAllImages();
                } else {
                  _pickImages();
                }
              },
              child: Container(
                width: size.width / 8,
                height: size.height / 16,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: images.length >= widget.countImage
                      ? Border.all(color: Colors.grey)
                      : Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: images.length >= widget.countImage
                    ? const Icon(Icons.delete_forever_rounded,
                        color: Colors.grey)
                    : const Icon(Icons.image, color: Colors.green),
              ),
            ),
            images.isNotEmpty
                ? Row(
                    children: List.generate(
                      images.length,
                      (index) => InkWell(
                        onTap: () => _removeImage(index),
                        child: Container(
                          width: size.width / 8,
                          height: size.height / 16,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 2,
                          ),
                          child: Image.file(
                            File(images[index].path),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}

class ImagePickerFormField extends FormField<List<XFile>> {
  ImagePickerFormField({
    Key? key,
    FormFieldSetter<List<XFile>>? onSaved,
    FormFieldValidator<List<XFile>>? validator,
    List<XFile> initialValue = const [],
    AutovalidateMode autovalidate = AutovalidateMode.disabled,
    int maxLength = 30,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidate,
          builder: (FormFieldState<List<XFile>> state) {
            BuildContext context = state.context;
            List<XFile> images = state.value ?? [];

            Size size = MediaQuery.of(context).size;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (images.length >= maxLength) {
                          state.didChange([]);
                        } else {
                          try {
                            final List<XFile>? images =
                                await ImagePicker().pickMultiImage();
                            if (images == null) return;

                            // some magic to limit image pick

                            int length =
                                maxLength - state.value!.length - images.length;
                            length = length < 0 ? 0 : length;

                            state.didChange(images.take(length).toList());

                            // end
                          } on PlatformException catch (e) {
                            debugPrint("$e");
                          }
                        }
                      },
                      child: Container(
                        width: size.width / 8,
                        height: size.height / 16,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: images.length >= maxLength
                              ? Border.all(color: Colors.grey)
                              : Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: images.length >= maxLength
                            ? const Icon(Icons.delete_forever_rounded,
                                color: Colors.grey)
                            : const Icon(Icons.image, color: Colors.green),
                      ),
                    ),
                    images.isNotEmpty
                        ? Row(
                            children: List.generate(
                              images.length,
                              (index) => InkWell(
                                onTap: () {
                                  images.removeAt(index);
                                  state.didChange(images);
                                },
                                child: Container(
                                  width: size.width / 8,
                                  height: size.height / 16,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 2,
                                  ),
                                  child: Image.file(
                                    File(images[index].path),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                if (state.hasError)
                  Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            );
          },
        );
}
