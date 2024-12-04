import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselBanner extends StatelessWidget {
  final List<String> imagePaths;

  const CarouselBanner({required this.imagePaths, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0, // Tentukan tinggi carousel
        aspectRatio: 16 / 9, // Tetap menjaga rasio aspek jika diperlukan
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
              height: 200, // Tentukan tinggi yang konsisten
              width: MediaQuery.of(context).size.width, // Lebar penuh
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imagePath,
                  fit: BoxFit
                      .cover, // Gambar mengisi ruang dan tetap menjaga rasio aspek
                  width: double.infinity, // Memastikan gambar memenuhi lebar
                  height: double.infinity, // Memastikan gambar memenuhi tinggi
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
