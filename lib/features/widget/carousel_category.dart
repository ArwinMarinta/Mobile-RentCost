import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselCategory extends StatefulWidget {
  final List<String> imagePaths;
  // final double height;
  // final bool autoPlay;

  const CarouselCategory(
      {required this.imagePaths,
      // required this.height,
      // required this.autoPlay,
      super.key});

  @override
  State<CarouselCategory> createState() => _CarouselCategoryState();
}

class _CarouselCategoryState extends State<CarouselCategory> {
  @override
  Widget build(BuildContext context) {
    bool pauseAutoPlayOnTouch = true; // Status autoplay

    void togglePauseOnTouch() {
      setState(() {
        pauseAutoPlayOnTouch = false;
      });
    }

    print(pauseAutoPlayOnTouch);

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
            pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
            viewportFraction: 0.2,
            scrollDirection: Axis.horizontal,
          ),
          items: widget.imagePaths.map((String imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  // width: double.infinity, // Lebar penuh
                  height: MediaQuery.of(context).size.height, // Tinggi penuh
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(imagePath),
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
            pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
            viewportFraction: 0.2,
            scrollDirection: Axis.horizontal,
            reverse: true,
          ),
          items: widget.imagePaths.map((String imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  // width: double.infinity, // Lebar penuh
                  height: MediaQuery.of(context).size.height, // Tinggi penuh
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage(imagePath),
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
