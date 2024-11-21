import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselBanner extends StatelessWidget {
  final List<String> imagePaths;
  // final double height;
  // final bool autoPlay;

  const CarouselBanner(
      {required this.imagePaths,
      // required this.height,
      // required this.autoPlay,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        pauseAutoPlayOnTouch: true,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: imagePaths.map((String imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              // width: double.infinity, // Lebar penuh
              height: MediaQuery.of(context).size.height, // Tinggi penuh
              width: MediaQuery.of(context).size.width,
              // margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.fill,
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
