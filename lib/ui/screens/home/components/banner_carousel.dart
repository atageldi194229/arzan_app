import 'package:cached_network_image/cached_network_image.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/providers/banner_provider.dart';
import 'package:tm/core/providers/region_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({Key? key}) : super(key: key);

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    List items = context.watch<BannerProvider>().banners;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            height: double.infinity,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: items
              .map<Widget>(
                (item) => SizedBox(
                  width: double.infinity,
                  // color: kSoftGreen,
                  // child: FadeInImage.assetNetwork(
                  //   placeholder: imagePlaceholder,
                  //   image: item.image,
                  //   fit: BoxFit.fill,
                  //   // height: carouselHeight / 3,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: item.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                          // colorFilter:
                          // ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              )
              .toList(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              items.length,
              (index) => AnimatedDot(active: _current == index),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedDot extends StatelessWidget {
  AnimatedDot({Key? key, this.active = false}) : super(key: key);
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
