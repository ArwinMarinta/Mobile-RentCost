import 'package:rentcost/features/model/costum.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselCard extends StatelessWidget {
  final List<Costum> costum;

  const CarouselCard({required this.costum, super.key});

  @override
  Widget build(BuildContext context) {
    print(costum);
    return CarouselSlider(
      options: CarouselOptions(
        // height: 500.0,
        aspectRatio: 1,
        enableInfiniteScroll: false,
        autoPlay: false,
        initialPage: 0,
        // autoPlayInterval: const Duration(seconds: 4),
        // autoPlayAnimationDuration: const Duration(milliseconds: 800),
        // pauseAutoPlayOnTouch: true,
        viewportFraction: 0.4,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
      items: costum.map((Costum data) {
        return Builder(
          builder: (BuildContext context) {
            if (data.path.isNotEmpty) {
              return Container(
                // width: double.infinity, // Lebar penuh
                height: MediaQuery.of(context).size.height, // Tinggi penuh
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(data.path),
                    ),
                    Container(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(data.name)],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey, // Warna latar fallback
                child: const Center(
                  child: Text(
                    "Gambar tidak tersedia",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
