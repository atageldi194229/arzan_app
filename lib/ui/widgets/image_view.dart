import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/photo_view_gallery/photo_view_gallery_screen.dart';

class ImageView extends StatefulWidget {
  final List<String> images;

  const ImageView({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          onPageChanged: (index) => setState(() => (_current = index)),
          // scrollDirection: Axis.vertical,
          children: List.generate(
            widget.images.length,
            (index) => InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewGalleryScreen(
                      images: widget.images,
                    ),
                  ),
                );
              },
              child: _buildImageWidget(widget.images[index]),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (index) => _AnimatedDot(active: _current == index),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget(String image) {
    return FadeInImage.assetNetwork(
      placeholder: imagePlaceholder,
      image: image,
      fit: BoxFit.contain,
    );
  }
}

class _AnimatedDot extends StatelessWidget {
  _AnimatedDot({Key? key, this.active = false}) : super(key: key);
  final Map<bool, double> dotHeight = {
    true: 15,
    false: 7,
  };
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: dotHeight[active],
      width: dotHeight[active],
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          shape: BoxShape.circle,
          color: active ? kSoftGreen : Colors.white),
    );
  }
}
