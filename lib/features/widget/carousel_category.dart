import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselCategory extends StatelessWidget {
  final List<String> imagePaths;

  const CarouselCategory({required this.imagePaths, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 60.0,
            aspectRatio: 1,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 1),
            // autoPlayAnimationDuration: const Duration(milliseconds: 600),
            pauseAutoPlayOnTouch: false,
            viewportFraction: 0.2,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
          ),
          items: imagePaths.map((String imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  // width: double.infinity, // Lebar penuh
                  height: MediaQuery.of(context).size.height, // Tinggi penuh
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.fill,
                      )),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16.0),
        CarouselSlider(
          options: CarouselOptions(
            height: 60.0,
            aspectRatio: 1,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 1),
            // autoPlayAnimationDuration: const Duration(milliseconds: 600),
            pauseAutoPlayOnTouch: false,
            viewportFraction: 0.2,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            reverse: true,
          ),
          items: imagePaths.map((String imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  // width: double.infinity, // Lebar penuh
                  height: MediaQuery.of(context).size.height, // Tinggi penuh
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.fill,
                      )),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
